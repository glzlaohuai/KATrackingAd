package com.appicplay.katracking.event
{
	import flash.events.Event;

	public class LogEvent extends Event
	{
		public static const LOG_PRINT:String = "LogPrint";
		
		public var log:String;
		
		public function LogEvent(type:String,log:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.log = log;
			super(type, bubbles, cancelable);
		}
	}
}