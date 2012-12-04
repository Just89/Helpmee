package game 
{
	import alternativa.engine3d.core.events.MouseEvent3D;
	import alternativa.engine3d.core.Object3D;
	import assets.LoadManager;
	import assets.MapManager;
	import assets.Model;
	import assets.ModelManager;
	import assets.ObjectManager;
	import assets.Texture;
	import events.ObjectEvent;
	import events.TextureEvent;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import game.actions.IAction;
	import game.data.Tile;
	
	/**
	 * ...
	 * <b>Copyright 2011</b>, Frank Bos. All rights reserved.
	 * Frank Bos permits you to use and modify this file. As long as this copyright notice will stay intact.
	 * @author Automaticoo
	 */
	public class TileEngine extends Object3D 
	{
		private var _floor:Floor;
		private var _tiles:Vector.<Tile>;
		private var _mapManager:MapManager;
		private var _stage:Stage;
		
		private var _selectedTextureID:int = -1;
		private var _selectedModel:Object3D = null;
		private var _selectedModelOrigin:Model;
		
		public function TileEngine(mapManager:MapManager, stage:Stage) 
		{
			this._stage = stage;
			_mapManager = mapManager;
			_floor = new Floor(_mapManager.tiles);
			_floor.x = -_floor.width/2;
			_floor.y = -_floor.height/2;
			_tiles = _floor.tiles;
			addChild(_floor);
			
			stage.addEventListener(ObjectEvent.SELECTED, onObjectSelect);
			stage.addEventListener(TextureEvent.SELECTED, onTextureSelect);
			
			stage.addEventListener(ObjectEvent.DESELECTED, onDeselect);
			stage.addEventListener(TextureEvent.DESELECTED, onDeselect);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			
			_floor.addEventListener(MouseEvent3D.CLICK, onClick);
			
			LoadManager.instance.getObjects(function(objectManager:ObjectManager):void { 
				for (var i:int ; i < objectManager.objects.length; i++)
				{
					objectManager.objects[i].x -= _floor.width / 2;
					objectManager.objects[i].y -= _floor.height / 2;
					parent.addChild(objectManager.objects[i]);
				}
			});
		}
		
		private function onDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.LEFT)
			{
				if (_selectedModel  != null)
				{
					_selectedModel.rotationZ -= Math.PI / 2;
				}
			}
			else if (e.keyCode == Keyboard.RIGHT)
			{
				if (_selectedModel  != null)
				{
					_selectedModel.rotationZ += Math.PI / 2;
				}
			}
		}
		
		private function onClick(e:MouseEvent3D):void 
		{
			var point:Vector3D = new Vector3D(e.localX, e.localY, e.localZ);
				point.scaleBy(1 / 64);
				
			if (_selectedTextureID != -1)
			{
				getTile(point.x, point.y).textureID = _selectedTextureID;
			}
			
			if (_selectedModel != null)
			{
				LoadManager.instance.getObjects(function(objectManager:ObjectManager):void { 
						objectManager.setObject(_selectedModelOrigin, point.x, point.y, _selectedModel.rotationZ);
						_selectedModel = null;
						dispatchEvent(new ObjectEvent(ObjectEvent.PLACE, -1, false, false));
					});
			}
		}
		
		private function onDeselect(e:Event):void 
		{
			_floor.grid = false;
			_selectedTextureID = -1;
			
			if (_selectedModel != null)
			{
				parent.removeChild(_selectedModel);
				_selectedModel = null;
			}			

			removeEventListener(MouseEvent3D.MOUSE_MOVE, onMove);
		}
		
		private function onMove(e:MouseEvent3D):void 
		{
			var point:Vector3D = new Vector3D(e.localX, e.localY, e.localZ);
				point.scaleBy(1 / 64);
				point.x = Math.round(point.x);
				point.y = Math.round(point.y);
				point.z = Math.round(point.z);
				
			_selectedModel.x = point.x * 64 - _floor.width / 2;
			_selectedModel.y = point.y * 64 - _floor.height / 2;
		}
		
		private function onObjectSelect(e:ObjectEvent):void 
		{
			_floor.grid = true;
			
			LoadManager.instance.getModels(function(modelManager:ModelManager):void { 
				var model:Model = modelManager.getModelByID(e.id);
				
				_selectedModelOrigin = model;
				
				_selectedModel = model.model.clone();
				
				parent.addChild(_selectedModel);
				
				addEventListener(MouseEvent3D.MOUSE_MOVE, onMove);
				});
		}
		
		private function onTextureSelect(e:TextureEvent):void 
		{
			_floor.grid = true;
			_selectedTextureID = e.textureID;
		}
		
		public function getTile(x:int, y:int):Tile
		{
			return _tiles[x * _floor.segmentsW + y];
		}
	}
}