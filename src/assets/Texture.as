package assets 
{
	import assets.base.XMLLoader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * <b>Copyright 2011</b>, Frank Bos. All rights reserved.
	 * Frank Bos permits you to use and modify this file. As long as this copyright notice will stay intact.
	 * @author Automaticoo
	 */
	public class Texture 
	{
		private var _id:int;
		private var _name:String;
		private var _textureRect:Rectangle;
		private var _textureAsset:BitmapData;
		private var _cost:int;
		
		public function Texture(item:XML, textureAsset:BitmapData)
		{
			_textureAsset = textureAsset;
			_textureRect = new Rectangle(item.@x * 64, item.@y * 64, item.@w, item.@h);
			_name = item.@name;
			_cost = item.@cost;
			_id = item.@id;			
		}
		
		public function toString():String
		{
			return "Texture | id= " + id + " name= " + name + " \nRect= " + textureRect; 
		}
		
		public function get id():int 					{ return _id; 			}		
		public function get name():String 				{ return _name; 		}		
		public function get textureRect():Rectangle 	{ return _textureRect; 	}		
		public function get textureAsset():BitmapData	{ return _textureAsset;	}
		
		public function get cost():int 
		{
			return _cost;
		}
	}
}