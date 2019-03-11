using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using KATrackingAD;
using UnityEngine.UI;

public class KATrackingTest : MonoBehaviour
{

    public GameObject logObj;
    private Text logText;

    const string APP_ID = "test_test_test";
    const string CHANNEL_ID = "test_ad";

#if UNITY_ANDROID
    const string SPLASH_SLOTID = "zKyjJJyM";
    const string BANNER_SLOTID = "naArbAbz";
    const string INTERSTITIAL_SLOTID = "XYmLkMAx";
#elif UNITY_IOS
    const string SPLASH_SLOTID = "XqmJPMGw";
    const string BANNER_SLOTID = "naArbAbz";
    const string INTERSTITIAL_SLOTID = "geyzoWGx";
#else
    const string SPLASH_SLOTID = "zKyjJJyM";
    const string BANNER_SLOTID = "naArbAbz";
    const string INTERSTITIAL_SLOTID = "XYmLkMAx";
#endif

    // Use this for initialization
    void Start()
    {
        Debug.Log("start....");
        logText = logObj.transform.GetComponent<Text>();

        init();
    }

    // Update is called once per frame
    void Update()
    {
    }

    void OnEnable()
    {
        setupDelegates();
    }

    void OnDisable()
    {
        removeDelegates();
    }


    void removeDelegates()
    {
        KATracking.interstitialADLoadSuccess -= interstitialLoadSuccess;
        KATracking.interstitialADClick -= interstitialADClick;
        KATracking.interstitialADLoadFail -= interstitialLoadFailed;
        KATracking.interstitialADPresent -= interstitialADPresent;

        KATracking.splashADClick -= splashADClick;
        KATracking.splashADDismiss -= splashDismiss;
        KATracking.splashPresentFail -= splashPresentFail;
        KATracking.splashPresentSuccess -= splashPresentSuccess;

        KATracking.rewardVideoADPresentComplete -= rewardVideoPresentComplete;
        KATracking.rewardVideoADPresentFail -= rewardVideoADPresentFail;
        KATracking.rewardVideoADPresentSkip -= rewardVideoADPresentSkip;
        KATracking.rewardVideoADPresentSuccess -= rewardVideoADPresentSuccess;
    }


    void setupDelegates()
    {
        KATracking.interstitialADLoadSuccess += interstitialLoadSuccess;
        KATracking.interstitialADClick += interstitialADClick;
        KATracking.interstitialADLoadFail += interstitialLoadFailed;
        KATracking.interstitialADPresent += interstitialADPresent;
        KATracking.interstitialADDismiss += interstitialADDismiss;

        KATracking.splashADClick += splashADClick;
        KATracking.splashADDismiss += splashDismiss;
        KATracking.splashPresentFail += splashPresentFail;
        KATracking.splashPresentSuccess += splashPresentSuccess;

        KATracking.rewardVideoADPresentComplete += rewardVideoPresentComplete;
        KATracking.rewardVideoADPresentFail += rewardVideoADPresentFail;
        KATracking.rewardVideoADPresentSkip += rewardVideoADPresentSkip;
        KATracking.rewardVideoADPresentSuccess += rewardVideoADPresentSuccess;

        KATracking.bannerPresentScreen += bannerBeClicked;
        KATracking.bannerLoadFailed += bannerLoadFailed;
        KATracking.bannerLoadComplete += bannerLoadComplete;
        KATracking.bannerPresentScreenDismissed += bannerPresentScreenDismissed;
    }


    public void init()
    {
        KATracking.init("test_test_test", "test_ad");
    }




    //banner回调
    void bannerBeClicked(string slotID)
    {
        log("bannerBeClicked,slotID: " + slotID);
    }

    void bannerLoadFailed(string slotID, string reason)
    {
        log("bannerLoadFailed, slotID: " + slotID + ", reason: " + reason);
    }

    void bannerLoadComplete(string slotID)
    {
        log("bannerLoadComplete,slotID: " + slotID);
    }

    void bannerPresentScreenDismissed(string slotID)
    {
        log("bannerPresentScreenDismissed,slotID: " + slotID);
    }




    //interstitial 回调
    void interstitialLoadSuccess(string slotID)
    {
        log("interstitialLoadSuccess,slotID:" + slotID);
    }

    void interstitialADPresent(string slotID)
    {
        log("interstitialADPresent,slotID:" + slotID);
    }

    void interstitialADDismiss(string slotID)
    {
        log("interstitialADDismiss,slotID:" + slotID);
    }


    void interstitialADClick(string slotID)
    {
        log("interstitialADClick,slotID:" + slotID);
    }

    void interstitialLoadFailed(string slotID, string reason)
    {
        log("interstitialLoadFailed,slotID:" + slotID + ",reason:" + reason);

    }

    //splash 回调
    void splashADClick(string slotID)
    {
        log("splashADClick,slotID:" + slotID);

    }

    void splashDismiss(string slotID)
    {
        log("splashDismiss,slotID:" + slotID);

    }

    void splashPresentSuccess(string slotID)
    {
        log("splashPresentSuccess,slotID:" + slotID);
    }

    void splashPresentFail(string slotID, string reason)
    {
        log("splashPresentFail,slotID:" + slotID + ",reason:" + reason);
    }

    //rewardVideo回调
    void rewardVideoPresentComplete()
    {
        log("rewardVideoPresentComplete...");
    }

    void rewardVideoADPresentFail(string reason)
    {
        log("rewardVideoADPresentFail,reason:" + reason);
    }

    void rewardVideoADPresentSkip()
    {
        log("rewardVideoADPresentSkip");
    }

    void rewardVideoADPresentSuccess()
    {
        log("rewardVideoADPresentSuccess");
    }

    void log(string logMsg)
    {
        Debug.Log(logMsg);
        logText.text = logText.text + "\n" + logMsg;
    }

    public void loadInterstitial()
    {
        log("loadInterstitial...");
        KATracking.loadInterstitial(INTERSTITIAL_SLOTID);
    }

    public void showInterstitial()
    {
        log("show interstitial");
        if (KATracking.isInterstitialAvaliable(INTERSTITIAL_SLOTID))
        {
            log("interstitial is ready");
            KATracking.showInterstitial(INTERSTITIAL_SLOTID);
        }
        else
        {
            log("interstitial is not ready.");
        }
    }

    public void showSplash()
    {
        log("showSplash...");
        KATracking.showSplash(SPLASH_SLOTID);
    }

    public void showRewardVideoAD()
    {
        log("showRewardVideo...");
        if (KATracking.isRewardVideoADAvaliable())
        {
            KATracking.showRewardVideoAD();
        }
    }

    public void loadBanner()
    {
        int[] iosDeviceSize = KATracking.getDeviceScreenSize();
        log("loadBanner，screenSize：" + iosDeviceSize[0] + "," + iosDeviceSize[1]);
        KATracking.loadAndPresentBanner(BANNER_SLOTID, KATracking.BANNER_SIZE.BANNER_SIZE_320_50, iosDeviceSize[0] / 2, iosDeviceSize[1] - 50 / 2);
    }

    public void showBanner()
    {
        log("showBanner...");
        KATracking.showBanner(BANNER_SLOTID);
    }


    public void hideBanner()
    {
        log("hideBanner...");
        KATracking.hideBanner(BANNER_SLOTID);
    }


    public void removeAndDestroyBanner()
    {
        log("removeAndDestroyBanner...");
        KATracking.removeAndDestroyBanner(BANNER_SLOTID);
    }


    public void showChannelID()
    {
        log("channelID is:" + KATrackingAD.KATracking.getChannelID());
    }


    public void clearLog()
    {
        logText.text = "";
    }




}
