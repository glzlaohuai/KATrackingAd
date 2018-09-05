﻿using System;
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

        private static string BANNER_SIZE_320_50_STR = "BANNER_SIZE_320_50";
        private static string BANNER_SIZE_468_60_STR = "BANNER_SIZE_468_60";
        private static string BANNER_SIZE_728_90_STR = "BANNER_SIZE_728_90";

        public enum BANNER_SIZE
        {
            BANNER_SIZE_320_50,
            BANNER_SIZE_480_60,
            BANNER_SIZE_728_90
        }

#if UNITY_IOS // && !UNITY_EDITOR
        [DllImport("__Internal")] private static extern void doInit(string appID, string appChannel);

        [DllImport("__Internal")] private static extern void doLoadInterstitial(string slotID);
        [DllImport("__Internal")] private static extern void doShowInterstitial(string slotID);
        [DllImport("__Internal")] private static extern bool doCheckIsInterstitialAvaliable(string slotID);

        [DllImport("__Internal")] private static extern void doShowSplash(string slotID);

        [DllImport("__Internal")] private static extern void doLoadRewardVideo();
        [DllImport("__Internal")] private static extern void doShowRewardVideo();
        [DllImport("__Internal")] private static extern bool doCheckIsRewardVideoAvaliable();

        [DllImport("__Internal")] private static extern void doLoadBanner(string slotID, string bannerSize);
        [DllImport("__Internal")] private static extern void doShowBanner(string slotID);
        [DllImport("__Internal")] private static extern void doHideBanner(string slotID);
        [DllImport("__Internal")] private static extern void doSetBannerPosition(string slotID, int x, int y);
        [DllImport("__Internal")] private static extern void doRemoveAndDestroyBanner(string slotID);

        [DllImport("__Internal")] private static extern string doGetScreenSize();
#endif

        public static void init(string appID, string appChannel)
        {
            createDelegateObj();
#if UNITY_IOS
            doInit(appID, appChannel);
#endif
        }

        public static void loadInterstitial(string slotID)
        {
#if UNITY_IOS
            doLoadInterstitial(slotID);
#endif
        }

        public static void showInterstitial(string slotID)
        {
#if UNITY_IOS
            doShowInterstitial(slotID);
#endif
        }

        public static bool isInterstitialAvaliable(string slotID)
        {
#if UNITY_IOS
            return doCheckIsInterstitialAvaliable(slotID);
#endif
            return false;
        }


        public static void showSplash(string slotID)
        {
#if UNITY_IOS
            doShowSplash(slotID);
#endif
        }

        public static void loadRewardVideoAD()
        {
#if UNITY_IOS
            doLoadRewardVideo();
#endif
        }

        public static void showRewardVideoAD()
        {
#if UNITY_IOS
            doShowRewardVideo();
#endif
        }

        public static void loadAndPresentBanner(string slotID, BANNER_SIZE bannerSize, int x, int y)
        {
            string bannerSizeStr = BANNER_SIZE_320_50_STR;
            switch (bannerSize)
            {
                case BANNER_SIZE.BANNER_SIZE_320_50:
                    bannerSizeStr = BANNER_SIZE_320_50_STR;
                    break;
                case BANNER_SIZE.BANNER_SIZE_480_60:
                    bannerSizeStr = BANNER_SIZE_468_60_STR;
                    break;
                case BANNER_SIZE.BANNER_SIZE_728_90:
                    bannerSizeStr = BANNER_SIZE_728_90_STR;
                    break;
                default:
                    break;
            }

#if UNITY_IOS
            doLoadBanner(slotID, bannerSizeStr);
            doShowBanner(slotID);
            doSetBannerPosition(slotID, x, y);
#endif
        }

        public static int[] getIOSDeviceScreenSize()
        {
#if UNITY_IOS
            string screenSizeStr = doGetScreenSize();
            string[] splits = screenSizeStr.Split('#');
            return new int[] { int.Parse(splits[0]), int.Parse(splits[1]) };

#else
            return new int[] { 0, 0 };
#endif
        }

        public static void showBanner(string slotID)
        {
#if UNITY_IOS
            doShowBanner(slotID);
#endif
        }

        public static void hideBanner(string slotID)
        {
#if UNITY_IOS
            doHideBanner(slotID);
#endif
        }

        public static void removeAndDestroyBanner(string slotID)
        {
#if UNITY_IOS
            doRemoveAndDestroyBanner(slotID);
#endif
        }

        public static void setPosition(string slotID, int x, int y)
        {
#if UNITY_IOS
            doSetBannerPosition(slotID, x, y);
#endif
        }



        public static bool isRewardVideoADAvaliable()
        {
#if UNITY_IOS
            return doCheckIsRewardVideoAvaliable();
#endif
            return true;
        }

        private static void createDelegateObj()
        {
            GameObject findObj = GameObject.Find(DELEGATE_NAME);
            if (findObj == null)
            {
                GameObject singleton = new GameObject(DELEGATE_NAME);
                singleton.AddComponent<KATracking>();
            }
        }


        //---开屏广告回调
        public void csSplashAdPresentDidSuccess(string slotID)
        {
            if (splashPresentSuccess != null)
            {
                splashPresentSuccess(slotID);
            }
        }

        public void csSplashAdPresentDidFail(string slotIDAndReason)
        {
            string[] splits = slotIDAndReason.Split('#');
            if (splashPresentFail != null)
            {
                splashPresentFail(splits[0], splits[1]);
            }
        }

        public void csSplashAdDidClick(string slotID)
        {
            if (splashADClick != null)
            {
                splashADClick(slotID);
            }
        }



        public void csSplashAdDidDismiss(string slotID)
        {
            if (splashADDismiss != null)
            {
                splashADDismiss(slotID);
            }
        }


        //----插屏广告回调

        public void csInterstitialAdLoadDidSuccess(string slotID)
        {
            if (interstitialADLoadSuccess != null)
            {
                interstitialADLoadSuccess(slotID);
            }
        }

        public void csInterstitialAdLoadDidFailForSlot(string slotIDAndReason)
        {

            string[] splits = slotIDAndReason.Split('#');

            if (interstitialADLoadFail != null)
            {
                interstitialADLoadFail(splits[0], splits[1]);
            }
        }

        public void csInterstitialADDismiss(string slotID)
        {
            if (interstitialADDismiss != null)
            {
                interstitialADDismiss(slotID);
            }
        }

        public void csInterstitialAdDidPresent(string slotID)
        {
            if (interstitialADPresent != null)
            {
                interstitialADPresent(slotID);
            }
        }


        public void csInterstitialAdDidClick(string slotID)
        {
            if (interstitialADClick != null)
            {
                interstitialADClick(slotID);
            }
        }


        //激励视频广告回调
        public void csIncentivizedAdPresentDidFailWithError(string reason)
        {
            if (rewardVideoADPresentFail != null)
            {
                rewardVideoADPresentFail(reason);
            }
        }

        public void csIncentivizedAdPresentDidSuccess()
        {
            if (rewardVideoADPresentSuccess != null)
            {
                rewardVideoADPresentSuccess();
            }
        }

        public void csIncentivizedAdPresentDidComplete()
        {
            if (rewardVideoADPresentComplete != null)
            {
                rewardVideoADPresentComplete();
            }
        }

        public void csIncentivizedAdPresentDidSkip()
        {
            if (rewardVideoADPresentSkip != null)
            {
                rewardVideoADPresentSkip();
            }
        }

        //banner回调
        public void csBannerAdCompleteLoadingWithAd(string slotID)
        {
            if (bannerLoadComplete != null)
            {
                bannerLoadComplete(slotID);
            }
        }

        public void csBannerAdFailedLoadingForSlot(string slotIDAndReason)
        {
            if (bannerLoadFailed != null)
            {
                bannerLoadFailed(slotIDAndReason.Split('#')[0], slotIDAndReason.Split('#')[1]);
            }
        }

        public void csBannerDidPresentScreen(string slotID)
        {
            if (bannerPresentScreen != null)
            {
                bannerPresentScreen(slotID);
            }
        }

        public void csBannerDidDismissScreen(string slotID)
        {
            if (bannerPresentScreenDismissed != null)
            {
                bannerPresentScreenDismissed(slotID);
            }
        }




        public static event Action<string> splashPresentSuccess;
        public static event Action<string, string> splashPresentFail;
        public static event Action<string> splashADClick;
        public static event Action<string> splashADDismiss;


        public static event Action<string> interstitialADLoadSuccess;
        public static event Action<string, string> interstitialADLoadFail;
        public static event Action<string> interstitialADPresent;
        public static event Action<string> interstitialADClick;
        public static event Action<string> interstitialADDismiss;

        public static event Action<string> rewardVideoADPresentFail;
        public static event Action rewardVideoADPresentSuccess;
        public static event Action rewardVideoADPresentComplete;
        public static event Action rewardVideoADPresentSkip;

        public static event Action<string> bannerLoadComplete;
        public static event Action<string, string> bannerLoadFailed;
        public static event Action<string> bannerPresentScreen;
        public static event Action<string> bannerPresentScreenDismissed;

    }
}
