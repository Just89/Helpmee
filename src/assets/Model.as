package assets 
{
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.loaders.ParserA3D;
	import alternativa.engine3d.loaders.TexturesLoader;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.objects.Surface;
	import alternativa.engine3d.resources.ExternalTextureResource;
	import alternativa.engine3d.resources.Geometry;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import game.World;
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class Model extends EventDispatcher
	{
		private var _fileName:String;
		private var _id:int;
		private var _icon:BitmapData = null;
		private var _model:Object3D = null;
		
		private var _item:XML;
		
		private var _category:String;
		
		private var _modelComplete:Boolean = false;
		private var _iconComplete:Boolean = false;
		
		public function Model(item:XML, category:String)
		{
			_category = category;
			_item = item;
			_fileName = item.filename;
			_id = item.@id;
			var iconLoader:Loader = new Loader();
				iconLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
				iconLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
				iconLoader.load(new URLRequest("objects/" + _fileName + ".png"));
				
			var loaderA3D:URLLoader = new URLLoader();
				loaderA3D.dataFormat = URLLoaderDataFormat.BINARY;
				loaderA3D.load(new URLRequest("objects/" + _fileName + ".A3D"));
				loaderA3D.addEventListener(Event.COMPLETE, onA3DLoad);
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			trace(e);
		}
		
		private function onComplete(e:Event):void 
		{
			var iconLoaderInfo:LoaderInfo = e.currentTarget as LoaderInfo;
				iconLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			_icon = Bitmap(iconLoaderInfo.content).bitmapData;
			
			_iconComplete = true;
			
			if (_iconComplete && _modelComplete)
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function onA3DLoad(e:Event):void 
		{
			URLLoader(e.currentTarget).removeEventListener(Event.COMPLETE, onA3DLoad);
			
			// Model parsing
			var parser:ParserA3D = new ParserA3D();
				parser.parse((e.target as URLLoader).data);
				
			_model = new Object3D();
			_model.rotationX = 180 * 0.0174532925;
			_model.scaleX = _model.scaleY = _model.scaleZ = 0.5;
			
			var textures:Vector.<ExternalTextureResource> = new Vector.<ExternalTextureResource>();
			
			for each (var object:Object3D in parser.objects) 
			{
				if (object is Mesh)
				{
					var mesh:Mesh = object as Mesh;
					
					for each(var meshTexture:XML in _item.meshes.mesh)
					{
						if (meshTexture.@name == mesh.name)
						{
							if (meshTexture.hasOwnProperty("color"))
							{
								mesh.setMaterialToAllSurfaces(new FillMaterial(uint(meshTexture.color), meshTexture.color.@alpha));
							}
							if (meshTexture.hasOwnProperty("texture"))
							{
								var texture:ExternalTextureResource = new ExternalTextureResource(meshTexture.texture);
									textures.push(texture);
								mesh.setMaterialToAllSurfaces(new TextureMaterial(texture));
							}
							if (meshTexture.hasOwnProperty("surface"))
							{
								for (var i:int; i < meshTexture.surface.color.length(); i++)
								{
									mesh.getSurface(0).material = new FillMaterial(uint(meshTexture.surface.color[i]), meshTexture.surface.color[i].@alpha);
								}
							}
						}
					}
					_model.addChild(mesh);
				}
				else
				{
					_model.addChild(object);
				}
			}
			if (textures.length > 0)
			{
				var texturesLoader:TexturesLoader = new TexturesLoader(Main.stage3D.context3D);
				texturesLoader.loadResources(textures);
			}			
			
			var resources:Vector.<Resource> = _model.getResources(true, Geometry);
			
			for each (var resource:Resource in resources) 
			{
				resource.upload(Main.stage3D.context3D);
			}
			_modelComplete = true;
			
			if (_iconComplete && _modelComplete)
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		override public function toString():String
		{
			return "\n	Model : " + _fileName;
		}
		
		public function get icon():BitmapData 
		{
			return _icon;
		}
		
		public function get fileName():String 
		{
			return _fileName;
		}
		
		public function get model():Object3D 
		{
			return _model;
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function get category():String 
		{
			return _category;
		}
	}
}