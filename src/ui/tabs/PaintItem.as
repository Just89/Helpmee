package ui.tabs 
{
	import assets.Texture;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class PaintItem extends Item 
	{
		private var _bitmapData:BitmapData;
		private var _bitmap:Bitmap;
		private var _texture:Texture;
		
		
		public function PaintItem(texture:Texture) 
		{
			this._texture = texture;
			_bitmapData = new BitmapData(64, 64, false);
			_bitmapData.copyPixels(texture.textureAsset, texture.textureRect, new Point());
			
			_bitmap = new Bitmap(_bitmapData);
			
			addChild(_bitmap);
		}
		
		public function get texture():Texture 
		{
			return _texture;
		}
	}
}