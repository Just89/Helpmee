package ui 
{
	import com.bit101.components.PushButton;
	import events.CameraEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CameraController extends Sprite 
	{
		
		//ARRAYS :D
		private var _buttons:Array = [	[40, 20, "<", 0, leftButtonClick],
										[80, 20, ">", 0, rightButtonClick],
										//[80, -40, "+", 0, zoomInButtonClick],
										//[80, -20, "-", 0, zoomOutButtonClick],
										[80, 40, ">", 90, zoomOutButtonClick],
										[60, 20, ">", -90, zoomInButtonClick],
										[60, 20, "*", 0, resetButtonClick],
										[40, 0, "<<", 0, rotateLeftButtonClick],
										[80, 40, ">>", 0, rotateRightButtonClick],
										[100, 0, "<<", 90, panUpButtonClick],
										[40, 60, "<<", -90, panDownButtonClick],
									];
		
		
		public function CameraController() 
		{
			this.x = 660;
			this.y = 440;
			
			for (var i:int; i < _buttons.length; i++)
			{
				var button:PushButton = new PushButton(this, _buttons[i][0], _buttons[i][1], "");
					
					button.width = button.height = 20;
					button.rotation = _buttons[i][3];
					
					if (typeof(_buttons[i][2]) == "string")
					{
						button.label = _buttons[i][2];
					}
					else
					{						
						button.addChild(new _buttons[i][2]());
					}
					
					button.addEventListener(MouseEvent.MOUSE_DOWN, _buttons[i][4]);					
				addChild(button);
			}
			
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		private function onUp(e:MouseEvent):void 
		{
			dispatchEvent(new CameraEvent(CameraEvent.CAMERA_STOP, 0, true));
		}
		
		private function resetButtonClick(e:MouseEvent):void 
		{
			dispatchEvent(new CameraEvent(CameraEvent.RESET, 0, true));
		}
		private function zoomOutButtonClick(e:MouseEvent):void 
		{
			dispatchEvent(new CameraEvent(CameraEvent.CAMERA_ZOOM, -8, true));
		}
		private function zoomInButtonClick(e:MouseEvent):void 
		{
			dispatchEvent(new CameraEvent(CameraEvent.CAMERA_ZOOM, 8, true));
		}
		private function downButtonClick(e:MouseEvent):void 
		{
			dispatchEvent(new CameraEvent(CameraEvent.CAMERA_MOVE, 8, true));
		}
		private function upButtonClick(e:MouseEvent):void 
		{
			dispatchEvent(new CameraEvent(CameraEvent.CAMERA_MOVE, -8, true));
		}
		private function leftButtonClick(e:MouseEvent):void 
		{
			dispatchEvent(new CameraEvent(CameraEvent.CAMERA_STRAFE, -8, true));
		}
		private function rightButtonClick(e:MouseEvent):void 
		{
			dispatchEvent(new CameraEvent(CameraEvent.CAMERA_STRAFE, 8, true));
		}
		private function rotateLeftButtonClick(e:MouseEvent):void 
		{
			dispatchEvent(new CameraEvent(CameraEvent.CAMERA_ROTATE, 1, true));
		}
		private function rotateRightButtonClick(e:MouseEvent):void 
		{
			dispatchEvent(new CameraEvent(CameraEvent.CAMERA_ROTATE, -1, true));
		}
		private function panUpButtonClick(e:MouseEvent):void 
		{
			dispatchEvent(new CameraEvent(CameraEvent.CAMERA_PAN, 1, true));
		}
		private function panDownButtonClick(e:MouseEvent):void 
		{
			dispatchEvent(new CameraEvent(CameraEvent.CAMERA_PAN, -1, true));
		}
	}
}