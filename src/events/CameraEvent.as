package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Just
	 */
	public class CameraEvent extends Event 
	{
		//roteren
		public static const CAMERA_PAN:String = "camera_pan";
		//de camera zelf bewegen vooruit achteruit
		public static const CAMERA_ZOOM:String = "camera_zoom";
		//vanuit vaste positie camera bewegen
		public static const CAMERA_TILT:String = "camera_tilt";
		//de camera zelf bewegen links rechts
		public static const CAMERA_STRAFE:String = "camera_strafe";
		//de camera zelf bewegen omhoog en naarbeneden
		public static const CAMERA_MOVE:String = "camera_move";
			//camera roteren
		public static const CAMERA_ROTATE:String = "camera_rotate";
		//stop met alles waarmee iemand bezig was
		public static const CAMERA_STOP:String = "camera_stop";
		//centreer het scherm naar het midden
		public static const RESET:String = "camera_reset";
	
		
		
		private var _value:int;
		
		public function CameraEvent(type:String, value:int = 0, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this._value = value;
			
		} 
		
		public override function clone():Event 
		{ 
			return new CameraEvent(type, value, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CameraEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get value():int 
		{
			return _value;
		}
		
	}
	
}