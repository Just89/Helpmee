package assets 
{
	import assets.base.XMLLoader;
	import events.TextureEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import game.data.Tile;
	
	/**
	 * ...
	 * <b>Copyright 2011</b>, Frank Bos. All rights reserved.
	 * Frank Bos permits you to use and modify this file. As long as this copyright notice will stay intact.
	 * @author Automaticoo
	 */
	public class MapManager extends URLLoader
	{
		private var _tiles:Vector.<Tile>;
		
		private var _username:String;
		private var _townName:String;
		
		private var _complete:Boolean = false;
		
		public function MapManager(username:String) 
		{
			_username = username;
			addEventListener(Event.COMPLETE, finishedLoading);
			load(new URLRequest("town.xml"));
		}
		
		private function finishedLoading(e:Event):void 
		{
			removeEventListener(Event.COMPLETE, finishedLoading);
			
			var xml:XML = new XML(e.target.data);
			
			_townName = xml.object.town.name;
			
			//plain data we get from the server
			var rawMapData:String = xml.object.town.map.text();
			
			if (rawMapData != "")
			{				
				rawMapData = rawMapData.split("\r").join("").split("\n").join(" ");
				
				//Convert the map to a array
				var uintMap:Vector.<uint> = Vector.<uint>(rawMapData.split(" "));
				
				//count the tiles we need in rows and columns
				var tileLength:int = Math.sqrt(uintMap.length);
				
				//create a vector with enough places to hold all tiles in a one dimensional vector (performace wise faster that two dimensional array)
				_tiles = new Vector.<Tile>(uintMap.length, true);
				
				for (var x:uint = 0; x < tileLength; x++ )
				{
					for (var y:uint = 0; y < tileLength; y++ )
					{
						var tile:Tile = new Tile(x, y, uintMap[y * tileLength + x]);
							tile.addEventListener(TextureEvent.CHANGED, onChange);
						_tiles[x * tileLength + y] = tile;
					}
				}
			}
			
			_complete = true;
			dispatchEvent(new Event(LoadManager.COMPLETE));
		}
		
		private function onChange(e:TextureEvent):void 
		{
			var tile:Tile = e.tile;
			
			LoadManager.instance.getSignedInUser(function(user:UserManager):void {
					LoadManager.instance.getTextures(function(textureManager:TextureManager):void {
						user.statistics.cash -= textureManager.getTextureByID(tile.textureID).cost;
					});
				} );
		}
		
		public function get tiles():Vector.<Tile> 
		{
			return _tiles;
		}
		
		public function get username():String 
		{
			return _username;
		}
		
		public function get complete():Boolean 
		{
			return _complete;
		}
	}
}