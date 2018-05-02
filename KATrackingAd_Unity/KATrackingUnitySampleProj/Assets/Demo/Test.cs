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
	void Start ()
	{
		Debug.Log ("start....");
		logText = logObj.transform.GetComponent<Text> ();
		KATracking.init ("test_test_test", "test_ad");
	}
	
	// Update is called once per frame
	void Update ()
	{
	}

	void OnEnable ()
	{
		setupDelegates ();
	}

	//interstitial 回调
	void interstitialLoadSuccess (string slotID)
	{
		log ("interstitialLoadSuccess,slotID:" + slotID);
	}

	void interstitialADPresent (string slotID)
	{
		log ("interstitialADPresent,slotID:" + slotID);
	}

	void interstitialADClick (string slotID)
	{
		log ("interstitialADClick,slotID:" + slotID);
	}

	void interstitialLoadFailed (string slotID, string reason)
	{
		log ("interstitialLoadFailed,slotID:" + slotID + ",reason:" + reason);

	}

	//splash 回调
	void splashADClick (string slotID)
	{
		log ("splashADClick,slotID:" + slotID);

	}

	void splashDismiss (string slotID)
	{
		log ("splashDismiss,slotID:" + slotID);

	}

	void splashPresentSuccess (string slotID)
	{
		log ("splashPresentSuccess,slotID:" + slotID);
	}

	void splashPresentFail (string slotID, string reason)
	{
		log ("splashPresentFail,slotID:" + slotID + ",reason:" + reason);
	}

	//rewardVideo回调
	void rewardVideoPresentComplete ()
	{
		log ("rewardVideoPresentComplete...");
	}

	void rewardVideoADPresentFail (string reason)
	{
		log ("rewardVideoADPresentFail,reason:" + reason);
	}

	void rewardVideoADPresentSkip ()
	{
		log ("rewardVideoADPresentSkip");
	}

	void rewardVideoADPresentSuccess ()
	{
		log ("rewardVideoADPresentSuccess");
	}

	void log (string logMsg)
	{
		Debug.Log (logMsg);
		logText.text = logText.text + "\n" + logMsg;
	}




	public void loadInterstitial ()
	{
		log ("loadInterstitial...");
		KATracking.loadInterstitial ("DlGdpoGq");
	}

	public void showInterstitial ()
	{
		log ("show interstitial");
		if (KATracking.isInterstitialAvaliable ("DlGdpoGq")) {
			KATracking.showInterstitial ("DlGdpoGq");
		}
	}

	public void loadSplash ()
	{
		log ("showSplash...");
		KATracking.showSplash ("bPmPrQGq");
	}

	public void loadRewardVideo ()
	{
		log ("loadRewardVideo...");
		KATracking.loadRewardVideoAD ();
	}

	public void showRewardVideoAD ()
	{
		log ("showRewardVideo...");
		if (KATracking.isRewardVideoADAvaliable ()) {
			KATracking.showRewardVideoAD ();
		}
	}

	public void clearLog ()
	{
		logText.text = "";
	}




}
