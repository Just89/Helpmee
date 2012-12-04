package assets 
{
	import assets.base.XMLLoader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * <b>Copyright 2011</b>, Frank Bos. All rights reserved.
	 * Frank Bos permits you to use and modify this file. As long as this copyright notice will stay intact.
	 * @author Automaticoo
	 */
	public class TextureManager extends URLLoader
	{
		private static var _textureAsset:BitmapData;
		
		[Embed(source = '../../lib/textures/texture.jpg')]
		private var _texturesClass:Class;
		
		private var _textures:Vector.<Texture>;
		
		private var _complete:Boolean = false;
		
		public function TextureManager() 
		{
			_textureAsset = Bitmap(new _texturesClass()).bitmapData;
			
			super(new URLRequest("textures.xml"));
			
			addEventListener(Event.COMPLETE, onComplete);
		}
		
		public function getTextureByID(id:int):Texture
		{
			for (var i:int; i < _textures.length; i++)
			{
				if (_textures[i].id == id)
				{
					return _textures[i];
				}
			}
			return null;
		}		
		
		private function onComplete(e:Event):void
		{
			removeEventListener(Event.COMPLETE, onComplete);
			
			var xml:XML = new XML(e.target.data);
			_textures = new Vector.<Texture>();
			
			for each(var item:XML in xml.object.textures.item)
			{
				var texture:Texture = new Texture(item, _textureAsset);
				_textures.push(texture);
			}
			
			_complete = true;
			dispatchEvent(new Event(LoadManager.COMPLETE));
		}
		
		public function get textures():Vector.<Texture> 
		{
			return _textures;
		}
		
		public function get complete():Boolean 
		{
			return _complete;
		}
	}
}