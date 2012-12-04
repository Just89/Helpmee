package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class ObjectEvent extends Event 
	{
		public static const PLACE:String = "place_object";
		public static const DELETE:String = "delete_object";
		public static const SELECTED:String = "selected_object";
		public static const DESELECTED:String = "deselected_object";
		
		private var _id:int;
		
		public function ObjectEvent(type:String, modelID:int, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			_id = modelID;
			super(type, bubbles, cancelable);
		}
		
		public override function toString():String 
		{ 
			return formatToString("ObjectEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get id():int 
		{
			return _id;
		}
		
	}
	
}