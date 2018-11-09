#! /bin/sh

PROJECT_PATH=$(pwd)/$UNITY_PROJECT_PATH
UNITY_BUILD_DIR=$(pwd)/Build
LOG_FILE=$UNITY_BUILD_DIR/unity_package.log
EXPORT_PATH=$(pwd)/$PROJECT_NAME.unitypackage
RELEASE_DIRECTORY=./release
KA_IOS_SDK_UNZIP_DIR=$(pwd)/ka_ios_sdk_unzipped
KA_IOS_SDK_ZIP_FILE=$(pwd)/KATrackingAd_iOS/KASDK+Demo.zip
KA_ANDROID_SDK_ZIP_FILE=$(pwd)/AppicPlayAD_Android/AppicPlaySDK.zip
KA_ANDROID_SDK_UNZIP_DIR=$(pwd)/ka_android_sdk_unzipped
KA_IOS_SDK_PATH=KASDK+Demo/KATrackingAdDemo/SDK/KASDK
KA_IOS_SDK_RESOURCE_BUNDLE_NAME=KAResources.bundle
KA_IOS_SDK_FRAMEWORK_NAME=KASDK.framework

ERROR_CODE=0

echo "Unzipping sdk zip file..."
mkdir $KA_IOS_SDK_UNZIP_DIR
mkdir $KA_ANDROID_SDK_UNZIP_DIR
unzip $KA_IOS_SDK_ZIP_FILE -d $KA_IOS_SDK_UNZIP_DIR
unzip $KA_ANDROID_SDK_ZIP_FILE -d $KA_ANDROID_SDK_UNZIP_DIR

#mv unzipped framework and resource.bundle to unity sample proj
echo "move framework and bundle to unity sample project"
mv $KA_IOS_SDK_UNZIP_DIR/$KA_IOS_SDK_PATH/$KA_IOS_SDK_RESOURCE_BUNDLE_NAME $PROJECT_PATH/Assets/Plugins/iOS/KATracking/libs/$KA_IOS_SDK_RESOURCE_BUNDLE_NAME
mv $KA_IOS_SDK_UNZIP_DIR/$KA_IOS_SDK_PATH/$KA_IOS_SDK_FRAMEWORK_NAME $PROJECT_PATH/Assets/Plugins/iOS/KATracking/libs/$KA_IOS_SDK_FRAMEWORK_NAME

#mv unzipped android aar files to unity sample project
echo "move android sdk's aar files to unity sample project"
cp $KA_ANDROID_SDK_UNZIP_DIR/AppicPlaySDK/* $PROJECT_PATH/Assets/Plugins/Android/KATracking/libs

echo "Exporting KAUnityPlugin package at=$EXPORT_PATH"
mkdir $UNITY_BUILD_DIR
/Applications/Unity/Unity.app/Contents/MacOS/Unity \
-batchmode \
-nographics \
-silent-crashes \
-logFile \
-projectPath "$PROJECT_PATH" \
-exportPackage "Assets/Plugins" "$EXPORT_PATH" \
-quit \
| tee "$LOG_FILE"

if [ $? = 0 ] ; then
echo "Created package successfully."
ERROR_CODE=0

echo "Packaging unity package into release..."
#Preprare release unity package by packing into ZIP
RELEASE_ZIP_FILE=$RELEASE_DIRECTORY/$PROJECT_NAME.zip

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

