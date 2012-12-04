package events 
{
	import flash.events.Event;
	import game.data.Tile;
	
	/**
	 * ...
	 * @author Just
	 */
	public class TextureEvent extends Event 
	{
		private var _tile:Tile;
		private var _textureID:int;
		
		public static const SELECTED:String = "texture_selected";
		public static const DESELECTED:String = "texture_deselected";
		public static const CHANGED:String = "texture_changed";
		
		public function TextureEvent(type:String, textureID:int, tile:Tile = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			_textureID = textureID;
			_tile = tile;
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new TextureEvent(type, _textureID, _tile, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TextureEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get tile():Tile { return _tile; }		
		
		public function get textureID():int { return _textureID; }
	}	
}