package com.appicplay.katracking
{
	import com.appicplay.katracking.event.KATrackingADEvent;
	import com.appicplay.katracking.event.LogEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class KATracking extends EventDispatcher
	{
		private static var _instance:KATracking;
		private static var _isCreating:Boolean;
		
		private var extContext:ExtensionContext;
		
		public function KATracking(appID:String,channelID:String)
		{
			super();
		}

		public static function initiate(appID:String, channelID:String):KATracking
		{
			if(_instance != null)
			{
				throw new Error("KATracking already initiated; use KATracking.instance to get instance.");
			}
			_isCreating = true;
			try
			{
				_instance = new KATracking(appID,channelID);
			}
			finally
			{
				_isCreating = false;
			}
			return _instance;
		}
		
		public static function get instance() : KATracking
		{
			if(_instance != null)
			{
				return _instance;
			}
			throw new Error("KATracking not initialized; call KATracking.init() first.");
		}

		//加载插屏
		public function loadInterstitial(slotID:String):void
		{
			dispatchEvent(new KATrackingADEvent(KATrackingADType.AD_INTERSTITIAL,KATrackingADEventType.EVENT_LOAD_SUCCESS,slotID,""));
		}
		
		//加载开屏
		public function showSplash(slotID:String):void
		{
			dispatchEvent(new KATrackingADEvent(KATrackingADType.AD_SPLASH,KATrackingADEventType.EVENT_LOAD_SUCCESS,slotID,""));
			dispatchEvent(new KATrackingADEvent(KATrackingADType.AD_SPLASH,KATrackingADEventType.EVENT_PRESENT,slotID,""));
			dispatchEvent(new KATrackingADEvent(KATrackingADType.AD_SPLASH,KATrackingADEventType.EVENT_AD_DISMISS,slotID,""));
		}
		
		//加载视频广告
		public function loadRewardVideo():void{
			dispatchEvent(new KATrackingADEvent(KATrackingADType.AD_REWARDVIDEO,KATrackingADEventType.EVENT_LOAD_SUCCESS,"",""));
			dispatchEvent(new KATrackingADEvent(KATrackingADType.AD_REWARDVIDEO,KATrackingADEventType.EVENT_PRESENT,"",""));
			dispatchEvent(new KATrackingADEvent(KATrackingADType.AD_REWARDVIDEO,KATrackingADEventType.EVENT_AD_DISMISS,"",""));
		}
		
		public function showRewardVideo():void
		{
			this.extContext.call("showRewardVideo");
		}
		
		public function isInterstitialReady(slotID:String):Boolean{
			return false;
		}
		
		public function isRewardVideoADReady():Boolean{
			return false;
		}
		
		public function showInterstitial(slotID:String):void{
			dispatchEvent(new KATrackingADEvent(KATrackingADType.AD_INTERSTITIAL,KATrackingADEventType.EVENT_PRESENT,slotID,""));
		}
		
		private function handleNativeEvent(event:StatusEvent):void
		{
			trace("native端发来事件："+event);

			if(event.code == LogEvent.LOG_PRINT){
				trace("native端log："+event.level);
				dispatchEvent(new LogEvent(LogEvent.LOG_PRINT,event.level));
			}else{
				var adType:String = event.code;
				var level:String = event.level;
				
				var splits:Array = level.split("#");
				
				var eventType:String = splits[0];
				var slotID:String = splits[1];
				var msg:String = splits[2];
				
				dispatchEvent(new KATrackingADEvent(adType,eventType,slotID,msg));
			}
		}
	}
}