package game.data 
{
	import assets.Texture;
	import events.TextureEvent;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import game.Floor;
	/**
	 * ...
	 * @author Automatic
	 */
	public class Tile extends EventDispatcher
	{
		//coordinates of this tile 
		private var _x:int;
		private var _y:int;
		
		//texture used on this tile
		private var _textureID:int;
		private var _rawCoordinates:Point;
		private var _price:int;
		
		public function Tile(x:int, y:int, textureID:int) 
		{
			_rawCoordinates = new Point(x * 64, y * 64);
			_textureID = textureID;
			_x = x;
			_y = y;
		}
		
		/**
		 * Get coordinates in pixels
		 */
		public function get rawCoordinates():Point 
		{
			return _rawCoordinates;
		}
		
		/**
		 * Check if this tile is available to build on
		 */
		public function get available():Boolean
		{
			return true;
		}
		
		/**
		 * Get coordinates of this tile
		 */
		public function get y():int 				{	return _y;				}		
		public function get x():int 				{	return _x;				}	
		
		public function get textureID():int { return _textureID; }
		
		public function set textureID(value:int):void 
		{
			if (_textureID == value) return;
			_textureID = value;
			dispatchEvent(new TextureEvent(TextureEvent.CHANGED, value, this));
		}
	}
}