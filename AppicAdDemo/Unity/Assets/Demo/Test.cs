using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using KATrackingAD;

public class Test : MonoBehaviour
{
	// Use this for initialization
	void Start ()
	{
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

	void OnDisable ()
	{
		KATracking.interstitialLoadSuccess -= interstitialLoadSuccess;
		KATracking.interstitialLoadFailed -= interstitialLoadFailed;
		KATracking.interstitialDismissed -= interstitialDismissed;
	}


	void setupDelegates ()
	{
		KATracking.interstitialLoadSuccess += interstitialLoadSuccess;
		KATracking.interstitialLoadFailed += interstitialLoadFailed;
		KATracking.interstitialDismissed += interstitialDismissed;
	}

	void interstitialLoadSuccess ()
	{
		Debug.Log ("c# interstitial load success");
	}

	void interstitialLoadFailed (string reason)
	{
		Debug.Log ("c# interstitial load failed, reason:" + reason);
	}

	void interstitialDismissed ()
	{
		Debug.Log ("c# interstitial dismissed");
	}


	public void loadInterstitial ()
	{
		Debug.Log ("load interstitial");
		KATracking.loadInterstitial ("VnyRWGWj");
	}

	public void showInterstitial ()
	{
		Debug.Log ("show interstitial");
		if (KATracking.isInterstitialAvaliable ("VnyRWGWj")) {
			KATracking.showInterstitial ("VnyRWGWj");
		}
	}

}
