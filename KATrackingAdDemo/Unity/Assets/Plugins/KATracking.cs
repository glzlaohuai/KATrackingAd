using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;
using System.Threading;

namespace KATrackingAD
{
	public class KATracking : MonoBehaviour
	{
		private static string delegateName = "KATrackingADServiceDelegate";

		#if UNITY_IOS // && !UNITY_EDITOR
		[DllImport ("__Internal")]private static extern void doInit (string appID, string appChannel);

		[DllImport ("__Internal")]private static extern void doLoadInterstitial (string slotID);

		[DllImport ("__Internal")]private static extern void doShowInterstitial (string slotID);

		[DllImport ("__Internal")]private static extern bool doCheckIsInterstitialAvaliable (string slotID);
		#endif

		public static void init (string appID, string appChannel)
		{
			createDelegateObj ();
			#if UNITY_IOS
			doInit (appID, appChannel);
			#endif
		}

		public static void loadInterstitial (string slotID)
		{
			#if UNITY_IOS
			doLoadInterstitial (slotID);
			#endif
		}

		public static void showInterstitial (string slotID)
		{
			#if UNITY_IOS
			doShowInterstitial (slotID);
			#endif
		}

		public static bool isInterstitialAvaliable (string slotID)
		{
			#if UNITY_IOS
			return doCheckIsInterstitialAvaliable (slotID);
			#endif
			return false;
		}

		private static void createDelegateObj ()
		{
			GameObject findObj = GameObject.Find (delegateName);
			if (findObj == null) {
				GameObject singleton = new GameObject (delegateName);
				singleton.AddComponent<KATracking> ();
			}
		}


		public void csInterstitialLoadSuccess ()
		{
			if (interstitialLoadSuccess != null) {
				interstitialLoadSuccess ();
			}
		}

		public void csInterstitialLoadFailed (string reason)
		{
			if (interstitialLoadFailed != null) {
				interstitialLoadFailed (reason);
			}
		}

		public void csInterstitialDismissed ()
		{
			if (interstitialDismissed != null) {
				interstitialDismissed ();
			}
		}


		public static event Action interstitialLoadSuccess;
		public static event Action<string> interstitialLoadFailed;
		public static event Action interstitialDismissed;
	}
}
