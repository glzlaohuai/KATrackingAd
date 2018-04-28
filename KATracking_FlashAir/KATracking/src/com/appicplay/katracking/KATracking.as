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
			extContext = ExtensionContext.createExtensionContext("com.appicplay.katracking","");
			if(!extContext){
				throw new Error("KATracking native extension is not supported on this platform");
			}
			extContext.addEventListener(StatusEvent.STATUS,handleNativeEvent);
			if (!_isCreating) 
			{
				throw new Error("use KATracking.init() instead of \'new KATracking()\'");
			}
			this.extContext.call("init",appID,channelID);
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
			this.extContext.call("loadInterstitial",slotID);
		}
		
		//加载开屏
		public function showSplash(slotID:String):void
		{
			this.extContext.call("presentSplash",slotID);
		}
		
		//加载视频广告
		public function loadRewardVideo():void{
			this.extContext.call("loadRewardVideo");
		}
		
		public function showRewardVideo():void
		{
			this.extContext.call("showRewardVideo");
		}
		
		public function isInterstitialReady(slotID:String):Boolean{
			return this.extContext.call("isInterstitialReady",slotID);
		}
		
		public function isRewardVideoADReady():Boolean{
			return this.extContext.call("isRewardVideoADReady");
		}
		
		public function showInterstitial(slotID:String):void{
		 	this.extContext.call("showInterstitial",slotID);
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