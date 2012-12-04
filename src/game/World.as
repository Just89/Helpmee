package game 
{
	import alternativa.engine3d.controllers.SimpleObjectController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.CullingPlane;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.lights.AmbientLight;
	import alternativa.engine3d.lights.OmniLight;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.primitives.Box;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import assets.LoadManager;
	import assets.MapManager;
	import assets.Model;
	import assets.ModelManager;
	import assets.UserManager;
	import events.CameraEvent;
	import events.ObjectEvent;
	import events.TextureEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display3D.textures.CubeTexture;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.media.Camera;
	import flash.text.TextField;
	import game.actions.PaintAction;
	import game.shapes.House;
	import game.shapes.Plane;
	
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class World extends Sprite 
	{
		public static const DEFAULT_POSITION:Vector3D = new Vector3D(0, 800, -500);
		public static const DEFAULT_PANNING:Number = 0.0174532925 * 60;
		
		private var _root:Object3D;
		private var _camera:Camera3D;
		
		private var _levelRoot:Object3D;
		private var _tileEngine:TileEngine;
		private var _loadManager:LoadManager;
		private var _cameraHandler:CameraHandler;
		
		public var _skyBox:WorldSkyBox;
		
		private var house:House;
		
		public function World() 
		{
			_root = new Object3D();
			_levelRoot = new Object3D();
			_camera = new Camera3D(0.1, 10000);
			_camera.view = new View(760, 600);
			_camera.z = DEFAULT_POSITION.z;
			_camera.x = DEFAULT_POSITION.x;
			_camera.y = DEFAULT_POSITION.y;
			_camera.rotationX = DEFAULT_PANNING;
			
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			LoadManager.instance.getMap("testUser", mapLoaded);
		}
		
		private function mapLoaded(mapManager:MapManager):void 
		{
			addChild(_camera.view);
			
			_tileEngine = new TileEngine(mapManager, stage);	
			
			_cameraHandler = new CameraHandler(_camera, stage, _levelRoot);
			
			_skyBox = new WorldSkyBox();
			
			_root.addChild(_camera);			
			_root.addChild(_levelRoot);
			_levelRoot.addChild(_tileEngine);		
			_levelRoot.addChild(_skyBox);
			_tileEngine.addEventListener(ObjectEvent.PLACE, prograte);			
			
			//_camera.diagramAlign = StageAlign.TOP_LEFT;
			//addChild(_camera.diagram);
			
			for each(var resource:Resource in _root.getResources(true)) 
			{
				resource.upload(Main.stage3D.context3D);
			}
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function prograte(e:Event):void 
		{
			dispatchEvent(new Event(e.type, true));
		}
		
		private function onEnterFrame(e:Event):void 
		{
			_camera.render(Main.stage3D);
			_cameraHandler.update();
		}
		
		public function get tileEngine():TileEngine 
		{
			return _tileEngine;
		}
	}
}