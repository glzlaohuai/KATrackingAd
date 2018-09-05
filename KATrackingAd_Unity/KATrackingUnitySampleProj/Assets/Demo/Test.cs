using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using KATrackingAD;
using UnityEngine.UI;

public class Test : MonoBehaviour
{

    public GameObject logObj;
    private Text logText;

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
        KATracking.loadInterstitial("geyzoWGx");
    }

    public void showInterstitial()
    {
        log("show interstitial");
        if (KATracking.isInterstitialAvaliable("geyzoWGx"))
        {
            log("interstitial is ready");
            KATracking.showInterstitial("geyzoWGx");
        }
        else
        {
            log("interstitial is not ready.");
        }
    }

    public void showSplash()
    {
        log("showSplash...");
        KATracking.showSplash("XqmJPMGw");
    }

    public void loadRewardVideo()
    {
        log("loadRewardVideo...");
        KATracking.loadRewardVideoAD();
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
        log("loadBanner...");

        int[] iosDeviceSize = KATracking.getIOSDeviceScreenSize();
        KATracking.loadAndPresentBanner("naArbAbz", KATracking.BANNER_SIZE.BANNER_SIZE_320_50, iosDeviceSize[0] / 2, 50 / 2);
    }

    public void showBanner()
    {
        log("showBanner...");
        KATracking.showBanner("naArbAbz");
    }


    public void hideBanner()
    {
        log("hideBanner...");
        KATracking.hideBanner("naArbAbz");
    }


    public void removeAndDestroyBanner()
    {
        log("removeAndDestroyBanner...");
        KATracking.removeAndDestroyBanner("naArbAbz");
    }



    public void clearLog()
    {
        logText.text = "";
    }

}
