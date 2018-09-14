using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;

#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.iOS.Xcode;
using UnityEditor.Callbacks;

#endif

namespace KATrackingAD
{
	public class KATrackingXcodeSetting : MonoBehaviour
	{
		[PostProcessBuild]
		public static void OnPostprocessBuild (BuildTarget BuildTarget, string path)
		{

			if (BuildTarget == BuildTarget.iOS) {
				string projPath = PBXProject.GetPBXProjectPath (path);
				PBXProject proj = new PBXProject ();

				proj.ReadFromString (File.ReadAllText (projPath));
				string target = proj.TargetGuidByName ("Unity-iPhone");

				//ObjC
				proj.AddBuildProperty (target, "OTHER_LDFLAGS", "-ObjC");
				//bitcode NO
				proj.SetBuildProperty (target, "ENABLE_BITCODE", "NO");

				// add extra framework(s)
				proj.AddFrameworkToProject (target, "SystemConfiguration.framework", false);
				proj.AddFrameworkToProject (target, "CoreTelephony.framework", false);
				proj.AddFrameworkToProject (target, "QuartzCore.framework", false);
				proj.AddFrameworkToProject (target, "GLKit.framework", false);
				proj.AddFrameworkToProject (target, "AdSupport.framework", false);
				proj.AddFrameworkToProject (target, "UIKit.framework", false);
				proj.AddFrameworkToProject (target, "StoreKit.framework", false);
				proj.AddFrameworkToProject (target, "CoreLocation.framework", false);
				proj.AddFrameworkToProject (target, "CFNetwork.framework", false);
				proj.AddFrameworkToProject (target, "CoreMotion.framework", false);
				proj.AddFrameworkToProject (target, "AVFoundation.framework", false);
				proj.AddFrameworkToProject (target, "CoreData.framework", false);
				proj.AddFrameworkToProject (target, "CoreText.framework", false);
				proj.AddFrameworkToProject (target, "WebKit.framework", false);
				proj.AddFrameworkToProject (target, "JavaScriptCore.framework", false);

				//添加lib
				AddLibToProject (proj, target, "libsqlite3.0.tbd");
				AddLibToProject (proj, target, "libxml2.2.tbd");
				AddLibToProject (proj, target, "libz.tbd");

				// rewrite to file
				File.WriteAllText (projPath, proj.WriteToString ());

				//修改plist文件
				string plistPath = Path.Combine (path, "Info.plist");
				PlistDocument plist = new PlistDocument ();
				plist.ReadFromFile (plistPath);

				PlistElementArray schemesArray = plist.root.CreateArray ("LSApplicationQueriesSchemes");
				schemesArray.AddString ("dianping");
				schemesArray.AddString ("imeituan");
				schemesArray.AddString ("com.suning.SuningEBuy");
				schemesArray.AddString ("openapp.jdmobile");
				schemesArray.AddString ("vipshop");
				schemesArray.AddString ("snssdk141");
				schemesArray.AddString ("ctrip");
				schemesArray.AddString ("suning");
				schemesArray.AddString ("qunariphone");
				schemesArray.AddString ("QunarAlipay");
				schemesArray.AddString ("qunaraphone");
				schemesArray.AddString ("yohobuy");
				schemesArray.AddString ("kaola");
				schemesArray.AddString ("agoda");
				schemesArray.AddString ("openapp.xzdz");
				schemesArray.AddString ("beibeiapp");
				schemesArray.AddString ("taobao");
				schemesArray.AddString ("tmall");
				// 写回到plist文件中
				plist.WriteToFile (plistPath);
			}
		}

		//添加lib方法
		static void AddLibToProject (PBXProject inst, string targetGuid, string lib)
		{
			string fileGuid = inst.AddFile ("usr/lib/" + lib, "Frameworks/" + lib, PBXSourceTree.Sdk);
			inst.AddFileToBuild (targetGuid, fileGuid);
		}
	}
}
