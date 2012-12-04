package ui
{
	import assets.LoadManager;
	import assets.UserManager;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class UserInterface extends Sprite 
	{
		private var _cameraController:CameraController;
		private var _tabInterface:TabInterface;
		private var _headerBar:HeaderBar
		
		public function UserInterface() 
		{
			_cameraController = new CameraController();
			_tabInterface = new TabInterface();
			_headerBar = new HeaderBar();
			addChild(_cameraController);
			addChild(_tabInterface);
			addChild(_headerBar);
			
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			e.stopImmediatePropagation();
		}
	}
}