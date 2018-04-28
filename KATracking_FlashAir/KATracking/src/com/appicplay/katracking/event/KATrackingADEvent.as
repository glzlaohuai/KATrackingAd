package com.appicplay.katracking.event
{
	import flash.events.Event;
	
	public class KATrackingADEvent extends Event
	{
		public static const AD_EVENT:String = "AD_EVENT";
		
		private var _adType:String;
		private var _eventType:String;
		private var _slotID:String;
		private var _msg:String;
		
		public function KATrackingADEvent(adType:String,eventType:String,slotID:String,msg:String)
		{
			super(AD_EVENT, false, false);
			
			this._adType = adType;
			this._eventType = eventType;
			this._slotID = slotID;
			this._msg = msg;
		}
		
		public function get eventType():String
		{
			return _eventType;
		}
		public function get slotID():String
		{
			return _slotID;
		}
		
		public function get adType():String
		{
			return _adType;
		}
		
		public function get msg():String
		{
			return _msg;
		}

	}
}