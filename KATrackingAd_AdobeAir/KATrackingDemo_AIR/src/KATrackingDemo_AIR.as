package
{
	import com.appicplay.katracking.KATracking;
	import com.appicplay.katracking.KATrackingADEventType;
	import com.appicplay.katracking.KATrackingADType;
	import com.appicplay.katracking.event.KATrackingADEvent;
	import com.appicplay.katracking.event.LogEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class KATrackingDemo_AIR extends Sprite
	{
		
		private var logText:TextField;
		
		public function KATrackingDemo_AIR()
		{
			super();
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			createUI();
			doInit();
		}
		
		private function createUI():void
		{
			logText = new TextField();
			logText.defaultTextFormat = new flash.text.TextFormat("Arial",25,0xff0000);
			logText.width = stage.stageWidth;
			logText.height = 400;
			logText.y=250;
			logText.multiline = true;
			logText.wordWrap = true;
			logText.text = "";
			addChild(logText);
			
			var loadInterstitialBtn:CustomSimpleButton = new CustomSimpleButton("loadInterstitial",loadInterstitial,30);
			loadInterstitialBtn.y=40;
			addChild(loadInterstitialBtn);
			
			var checkInterstitialReadyBtn:CustomSimpleButton = new CustomSimpleButton("IsInterstitialReady",checkIsInterstitialReady,30);
			checkInterstitialReadyBtn.y=40;
			checkInterstitialReadyBtn.x=220;
			addChild(checkInterstitialReadyBtn);
			
			var showInterstitialBtn:CustomSimpleButton = new CustomSimpleButton("showInterstitial",showInterstitial,30);
			showInterstitialBtn.y=80;
			addChild(showInterstitialBtn);
			
			var showSplashBtn:CustomSimpleButton = new CustomSimpleButton("showSplash",showSplash,30);
			showSplashBtn.y=120;
			addChild(showSplashBtn);
			
			var loadRewardVideoBtn:CustomSimpleButton = new CustomSimpleButton("loadVideo",loadRewardVideo,30);
			loadRewardVideoBtn.y=160;
			addChild(loadRewardVideoBtn);
			
			var checkRewardVideoBtn:CustomSimpleButton = new CustomSimpleButton("isRewardVideoReady",checkIsRewardVideoReady,30);
			checkRewardVideoBtn.y=160;
			checkRewardVideoBtn.x=220;
			addChild(checkRewardVideoBtn);
			
			var showRewardVideoBtn:CustomSimpleButton = new CustomSimpleButton("showRewardVideo",showRewardVideo,30);
			showRewardVideoBtn.y=200;
			addChild(showRewardVideoBtn);
			
			var clearBtn:CustomSimpleButton = new CustomSimpleButton("clearLog",clearLog,30);
			clearBtn.y=40;
			clearBtn.x=500;
			addChild(clearBtn);
		}
		
		private function clearLog(e:MouseEvent):void
		{
			logText.text = "";
		}
		
		private function checkIsRewardVideoReady(e:MouseEvent):void
		{
			var isReady:Boolean = KATracking.instance.isRewardVideoADReady();
			receiveSDKLog(new LogEvent(LogEvent.LOG_PRINT,"激励视频准备情况："+isReady));
		}
		
		
		private function loadRewardVideo(e:MouseEvent):void
		{
			KATracking.instance.loadRewardVideo();
		}
		
		private function showRewardVideo(e:MouseEvent):void
		{
			KATracking.instance.showRewardVideo();
		}
		
		private function loadInterstitial(e:MouseEvent):void
		{
			KATracking.instance.loadInterstitial("DlGdpoGq");
		}
		
		private function checkIsInterstitialReady(e:MouseEvent):void
		{
			var isReady:Boolean = KATracking.instance.isInterstitialReady("DlGdpoGq");
			receiveSDKLog(new LogEvent(LogEvent.LOG_PRINT,"插屏准备情况："+isReady));
		}
		
		private function showSplash(e:MouseEvent):void
		{
			KATracking.instance.showSplash("bPmPrQGq");
		}
		
		private function showInterstitial(e:MouseEvent):void
		{
			KATracking.instance.showInterstitial("DlGdpoGq");
		}
		
		public function receiveSDKLog(e:LogEvent):void
		{
			trace("native端log："+e.log);
			logText.appendText(e.log+"\n");
		}
		public function receiveADCallback(e:KATrackingADEvent):void
		{
			var msg :String = "adType:"+e.adType+", event:"+e.eventType+", slotID:"+e.slotID+",msg:"+e.msg;
			trace("native端log："+msg);
			logText.appendText(msg+"\n");
		}
		
		private function doInit():void
		{
			KATracking.initiate("test_test_test","test_ad");
			KATracking.instance.addEventListener(LogEvent.LOG_PRINT,receiveSDKLog);
			KATracking.instance.addEventListener(KATrackingADEvent.AD_EVENT,receiveADCallback);
		}
	}
	}

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class CustomSimpleButton extends Sprite {
	
	private var textField:TextField;
	private var clickEvent:Function;
	
	private var _width:Number;
	
	public function CustomSimpleButton(label:String,clickEvent:Function,textSize:Number) {
		super();
		
		mouseChildren = false;
		mouseEnabled=buttonMode=useHandCursor=true;
		
		textField = new TextField();
		textField.defaultTextFormat = new TextFormat("Arial",textSize,0xff0000);
		textField.mouseEnabled=textField.selectable = false;
		textField.text = label;
		textField.autoSize=TextFieldAutoSize.LEFT;
		
		redraw();
		addEventListener(MouseEvent.CLICK,clickEvent);
	}
	
	public function dispose():void
	{
		removeEventListener(MouseEvent.CLICK,clickEvent);
	}
	
	private function redraw():void
	{
		_width=_width||textField.width*1.1;
		
		graphics.clear();
		graphics.beginFill(0x444444);
		graphics.lineStyle(2,0);
		graphics.drawRoundRect(0,0,_width,textField.height*1.1,textField.height*0.8);
		graphics.endFill();
		
		textField.x=_width/2-(textField.width/2);
		textField.y=textField.height*0.05;
		addChild(textField);
	}
	
	override public function set width(value:Number):void
	{
		// TODO Auto Generated method stub
		this._width = value;
		redraw();
	}
	
	public function set label(value:String):void
	{
		textField.text = value;
		redraw();
	}
	
}