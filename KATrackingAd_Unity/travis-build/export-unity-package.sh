#! /bin/sh

echo "***********************************************"
echo "***************[ad plugin export]**************"
echo "***********************************************"

PROJECT_PATH=$(pwd)/$UNITY_PROJECT_PATH
UNITY_BUILD_DIR=$(pwd)/Build
LOG_FILE=$UNITY_BUILD_DIR/unity_package.log
EXPORT_PATH=$(pwd)/APSDK_Ad.unitypackage
RELEASE_DIRECTORY=./release

echo "project path: $PROJECT_PATH"
echo "export file: $EXPORT_PATH"

KA_IOS_SDK_UNZIP_DIR=$(pwd)/ka_ios_sdk_unzipped
KA_IOS_SDK_ZIP_FILE=$(pwd)/KASDK.zip

KA_ANDROID_SDK_ZIP_FILE=$(pwd)/AppicPlayAD_Android/AppicPlaySDK.zip
KA_ANDROID_SDK_UNZIP_DIR=$(pwd)/ka_android_sdk_unzipped

KA_IOS_SDK_FRAMEWORK_NAME=KASDK.framework

IOS_V_SEGMENT=${TRAVIS_TAG%%+*}
IOS_V_SENGMENT_LENGTH=${#IOS_V_SEGMENT}
IOS_V_NUM_LENGTH=$(($IOS_V_SENGMENT_LENGTH-3))
IOS_V_NUM=${IOS_V_SEGMENT:3:$IOS_V_NUM_LENGTH}

IOS_SDK_DOWNLOAD_URL="http://img.appicplay.com/sdk/Mediation/KASDK/KASDK.v"

echo "此次提交的tag：$TRAVIS_TAG"
echo "此次提交的ios的sdk版本号为：$IOS_V_NUM"
IOS_SDK_DOWNLOAD_URL=${IOS_SDK_DOWNLOAD_URL}${IOS_V_NUM}.zip
echo "iossdk从下载连接地址：$IOS_SDK_DOWNLOAD_URL"
echo "开始下载ios sdk..."

curl -o $KA_IOS_SDK_ZIP_FILE $IOS_SDK_DOWNLOAD_URL

if [ $? != 0 ] ; then
echo "ios sdk下载失败，build失败"
ERROR_CODE=1
exit $ERROR_CODE
fi


echo "ios sdk zip file: $KA_IOS_SDK_ZIP_FILE"
echo "ios sdk unzipped dir: $KA_IOS_SDK_UNZIP_DIR"

echo "android sdk zip file: $KA_ANDROID_SDK_ZIP_FILE"
echo "android sdk unzipped dir: $KA_ANDROID_SDK_UNZIP_DIR"

ERROR_CODE=0

echo "Unzipping sdk zip file..."
mkdir $KA_IOS_SDK_UNZIP_DIR
mkdir $KA_ANDROID_SDK_UNZIP_DIR

unzip $KA_IOS_SDK_ZIP_FILE -d $KA_IOS_SDK_UNZIP_DIR
unzip $KA_ANDROID_SDK_ZIP_FILE -d $KA_ANDROID_SDK_UNZIP_DIR

echo "ios ad sdk's files: "
ls $KA_IOS_SDK_UNZIP_DIR

echo "android ad sdk's files: "
ls $KA_ANDROID_SDK_UNZIP_DIR

#mv unzipped framework and resource.bundle to unity sample proj
echo "move ios ad framework to unity plugin project"
mv $KA_IOS_SDK_UNZIP_DIR/$KA_IOS_SDK_FRAMEWORK_NAME $PROJECT_PATH/Assets/Plugins/iOS/KATracking/libs/$KA_IOS_SDK_FRAMEWORK_NAME

echo "move android ad sdk's libs to unity plugin project"
cp $KA_ANDROID_SDK_UNZIP_DIR/* $PROJECT_PATH/Assets/Plugins/Android


echo "Exporting KAUnityPlugin package at=$EXPORT_PATH"
mkdir $UNITY_BUILD_DIR
/Applications/Unity/Unity.app/Contents/MacOS/Unity \
-batchmode \
-nographics \
-silent-crashes \
-logFile \
-projectPath "$PROJECT_PATH" \
-exportPackage "Assets" "$EXPORT_PATH" \
-quit \
| tee "$LOG_FILE"

if [ $? = 0 ] ; then
echo "Created package successfully."
ERROR_CODE=0

echo "Packaging unity package into release..."
#Preprare release unity package by packing into ZIP
RELEASE_ZIP_FILE=$RELEASE_DIRECTORY/APSDK_AD.zip

mkdir -p $RELEASE_DIRECTORY

echo "Preparing release"
cp "$EXPORT_PATH" "$RELEASE_DIRECTORY/"`basename "$EXPORT_PATH"`

echo "Files in release directory:"
ls $RELEASE_DIRECTORY

zip -6 -r $RELEASE_ZIP_FILE $RELEASE_DIRECTORY

echo "Release zip package ready. Zipinfo:"
zipinfo $RELEASE_ZIP_FILE

else
echo "Creating package failed. Exited with $?."
ls
ERROR_CODE=1
fi

#echo 'Build logs:'
#cat $LOG_FILE

echo "Export finished with code $ERROR_CODE"
exit $ERROR_CODE

