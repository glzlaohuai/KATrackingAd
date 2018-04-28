package com.appicplay.katracking
{
	/**
	 * as枚举也用class来定义，final class，标识广告事件
	 */
	public final class KATrackingADEventType
	{
		public static const EVENT_LOAD_SUCCESS:String = "EVENT_LOAD_SUCCESS";
		public static const EVENT_LOAD_FAILED:String = "EVENT_LOAD_FAILED";
		public static const EVENT_PRESENT:String = "EVENT_PRESENT";
		public static const EVENT_AD_CLICK:String = "EVENT_AD_CLICK";
		public static const EVENT_AD_DISMISS:String = "EVENT_AD_DISMISS";
		public static const EVENT_AD_SKIP:String = "EVENT_AD_SKIP";
	}
}