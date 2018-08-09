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
		private static string DELEGATE_NAME = "KATrackingADServiceDelegate";

		#if UNITY_IOS // && !UNITY_EDITOR
		[DllImport ("__Internal")]private static extern void doInit (string appID, string appChannel);

		[DllImport ("__Internal")]private static extern void doLoadInterstitial (string slotID);

		[DllImport ("__Internal")]private static extern void doShowInterstitial (string slotID);

		[DllImport ("__Internal")]private static extern bool doCheckIsInterstitialAvaliable (string slotID);

		[DllImport ("__Internal")]private static extern void doShowSplash (string slotID);

		[DllImport ("__Internal")]private static extern void doLoadRewardVideo ();

		[DllImport ("__Internal")]private static extern void doShowRewardVideo ();

		[DllImport ("__Internal")]private static extern bool doCheckIsRewardVideoAvaliable ();

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


		public static void showSplash (string slotID)
		{
			#if UNITY_IOS
			doShowSplash (slotID);
			#endif
		}

		public static void loadRewardVideoAD ()
		{
			#if UNITY_IOS
			doLoadRewardVideo ();
			#endif
		}

		public static void showRewardVideoAD ()
		{
			#if UNITY_IOS
			doShowRewardVideo ();
			#endif
		}


		public static bool isRewardVideoADAvaliable ()
		{
#if UNITY_IOS
			return doCheckIsRewardVideoAvaliable ();
#endif
            return true;
		}

		private static void createDelegateObj ()
		{
			GameObject findObj = GameObject.Find (DELEGATE_NAME);
			if (findObj == null) {
				GameObject singleton = new GameObject (DELEGATE_NAME);
				singleton.AddComponent<KATracking> ();
			}
		}


		//---开屏广告回调
		public void csSplashAdPresentDidSuccess (string slotID)
		{
			if (splashPresentSuccess != null) {
				splashPresentSuccess (slotID);
			}
		}

		public void csSplashAdPresentDidFail (string slotIDAndReason)
		{
			string[] splits = slotIDAndReason.Split ('#');
			if (splashPresentFail != null) {
				splashPresentFail (splits [0], splits [1]);
			}
		}

		public void csSplashAdDidClick (string slotID)
		{
			if (splashADClick != null) {
				splashADClick (slotID);
			}
		}


		public void csSplashAdDidDismiss (string slotID)
		{
			if (splashADDismiss != null) {
				splashADDismiss (slotID);
			}
		}


		//----插屏广告回调

		public void csInterstitialAdLoadDidSuccess (string slotID)
		{
			if (interstitialADLoadSuccess != null) {
				interstitialADLoadSuccess (slotID);
			}
		}

		public void csInterstitialAdLoadDidFailForSlot (string slotIDAndReason)
		{

			string[] splits = slotIDAndReason.Split ('#');

			if (interstitialADLoadFail != null) {
				interstitialADLoadFail (splits [0], splits [1]);
			}
		}

		public void csInterstitialADDismiss (string slotID)
		{
			if (interstitialADDismiss != null) {
				interstitialADDismiss (slotID);
			}
		}

		public void csInterstitialAdDidPresent (string slotID)
		{
			if (interstitialADPresent != null) {
				interstitialADPresent (slotID);
			}
		}


		public void csInterstitialAdDidClick (string slotID)
		{
			if (interstitialADClick != null) {
				interstitialADClick (slotID);
			}
		}


		//激励视频广告回调
		public void csIncentivizedAdPresentDidFailWithError (string reason)
		{
			if (rewardVideoADPresentFail != null) {
				rewardVideoADPresentFail (reason);
			}
		}

		public void csIncentivizedAdPresentDidSuccess ()
		{
			if (rewardVideoADPresentSuccess != null) {
				rewardVideoADPresentSuccess ();
			}
		}

		public void csIncentivizedAdPresentDidComplete ()
		{
			if (rewardVideoADPresentComplete != null) {
				rewardVideoADPresentComplete ();
			}
		}

		public void csIncentivizedAdPresentDidSkip ()
		{
			if (rewardVideoADPresentSkip != null) {
				rewardVideoADPresentSkip ();
			}
		}

		public static event Action<string> splashPresentSuccess;
		public static event Action<string,string> splashPresentFail;
		public static event Action<string> splashADClick;
		public static event Action<string> splashADDismiss;


		public static event Action<string> interstitialADLoadSuccess;
		public static event Action<string,string> interstitialADLoadFail;
		public static event Action<string> interstitialADPresent;
		public static event Action<string> interstitialADClick;
		public static event Action<string> interstitialADDismiss;

		public static event Action<string> rewardVideoADPresentFail;
		public static event Action rewardVideoADPresentSuccess;
		public static event Action rewardVideoADPresentComplete;
		public static event Action rewardVideoADPresentSkip;

	}
}
