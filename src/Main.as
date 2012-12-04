package
{
	import alternativa.engine3d.core.Resource;
	import assets.LoadManager;
	import assets.UserManager;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Window;
	import com.demonsters.debugger.MonsterDebugger;
	import events.ObjectEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.errors.IOError;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import game.World;
	import ui.UserInterface;
	
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class Main extends Sprite 
	{
		private var _world:World;
		private var _interface:UserInterface;
		private var _textField:TextField;		
		private static var _stage3D:Stage3D;
		
		public function Main():void
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_stage3D = stage.stage3Ds[0];
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreate);
			_stage3D.requestContext3D();
		}
		
		private function onClick(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://apps.facebook.com/helpmeegame/"), '_self'); // second argument is target
		}
		
		private function onContextCreate(e:Event):void 
		{
			_world = new World();
			addChild(_world);
			
			_interface = new UserInterface();
			addChild(_interface);
		}
		
		static public function get stage3D():Stage3D 
		{
			return _stage3D;
		}
	}
}