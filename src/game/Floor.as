package game 
{
	import alternativa.engine3d.materials.StandardMaterial;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import assets.LoadManager;
	import assets.Texture;
	import assets.TextureManager;
	import events.TextureEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import game.data.Tile;
	import game.shapes.Plane;
	
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class Floor extends Plane 
	{
		private var _grid:Boolean = false;		
		private var _rect:Rectangle;		
		private var _textureMaterial:TextureMaterial;
		private var _bitmapTextureResource:BitmapTextureResource;
		private var _texture:BitmapData;
		private var _oldTexture:BitmapData;
		
		private var _tiles:Vector.<Tile>;
		
		public function Floor(tiles:Vector.<Tile>) 
		{
			//create a vector with enough places to hold all tiles in a one dimensional vector (performace wise faster that two dimensional array)
			_tiles = tiles;
			
			//get map dimensions
			var tileLength:uint = Math.sqrt(_tiles.length);	
			
			//make the texture white on the start
			_texture = new BitmapData(tileLength * 64, tileLength * 64, false, 0xFFFFFF);
			
			
			LoadManager.instance.getTextures(onTextureLoaded);
			
			//create the plane
			super(null, tileLength * 64, tileLength * 64, tileLength, tileLength);
		}
		
		private function onTextureLoaded(textureManager:TextureManager):void 
		{
			for (var i:uint; i < _tiles.length; i++ )
			{
				_tiles[i].addEventListener(TextureEvent.CHANGED, onTileChange);
				
				var mTexture:Texture = textureManager.getTextureByID(_tiles[i].textureID);	
				_texture.copyPixels(mTexture.textureAsset, mTexture.textureRect, _tiles[i].rawCoordinates);
			}
			
			_bitmapTextureResource = new BitmapTextureResource(_texture);
			_textureMaterial = new TextureMaterial(_bitmapTextureResource);
			
			this.material = _textureMaterial;
			reAssignTexture();
		}
		
		private function onTileChange(e:TextureEvent):void 
		{
			LoadManager.instance.getTextures(
				function(textureManager:TextureManager):void
				{ 
					var mTexture:Texture = textureManager.getTextureByID(e.textureID);
					
					_texture.copyPixels(mTexture.textureAsset, mTexture.textureRect, e.tile.rawCoordinates);
					if (_oldTexture != null && _grid == true)
					{
						_oldTexture.copyPixels(mTexture.textureAsset, mTexture.textureRect, e.tile.rawCoordinates);
					}					
					reAssignTexture();
				});			
		}
		
		private function reAssignTexture():void
		{
			_bitmapTextureResource = new BitmapTextureResource(_texture);
			_textureMaterial = new TextureMaterial(_bitmapTextureResource);
			
			_bitmapTextureResource.upload(Main.stage3D.context3D);
			
			this.material = _textureMaterial;
		}

		public function get tiles():Vector.<Tile> { return _tiles; }		
		public function set tiles(value:Vector.<Tile>):void 
		{
			_tiles = value;
		}
		
		public function set grid(value:Boolean):void 
		{
			if (value == false && _oldTexture != null)
			{
				_texture = _oldTexture.clone();
				
				_oldTexture = null;
				
				reAssignTexture();
			}
			else if (value == true && _grid != true)
			{
				_oldTexture = _texture.clone();
				for (var x:uint; x < _texture.width; x += 64)
				{
					for (var y:uint = 0; y < _texture.height; y++)
					{
						_texture.setPixel(x, y, 0xFF0000);
					}
				}
				for (y = 0; y < _texture.width; y += 64)
				{
					for (x = 0; x < _texture.height; x++)
					{
						_texture.setPixel(x, y, 0xFF0000);
					}
				}
				reAssignTexture();
			}			
			_grid = value;
		}
	}
}