package assets 
{
	import assets.ObjectManager;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * <b>Copyright 2011</b>, Frank Bos. All rights reserved.
	 * Frank Bos permits you to use and modify this file. As long as this copyright notice will stay intact.
	 * @author Automaticoo
	 */
	public class LoadManager extends EventDispatcher
	{
		public static var COMPLETE:String = "Load_Completed"
		
		private static var _loadManager:LoadManager;
		
		private var _mapManager:MapManager;
		private var _textureManager:TextureManager;
		private var _modelManager:ModelManager;	
		private var _objectManager:ObjectManager;
		
		private var _myUser:UserManager;
		
		private var _onTextureCallBack:Vector.<Function> = new Vector.<Function>();
		private var _onMapCallback:Vector.<Function> = new Vector.<Function>();
		private var _onModelCallback:Vector.<Function> = new Vector.<Function>();
		private var _onSignedInUserCallback:Vector.<Function> = new Vector.<Function>();
		private var _onObjectCallback:Vector.<Function> = new Vector.<Function>();
		
		public static function get instance():LoadManager
		{
			if (_loadManager == null) {
				_loadManager = new LoadManager();
				return _loadManager;
			}else{
				return _loadManager;
			}
		}
		
		public function LoadManager() 
		{
			
		}
		
		public function getMap(username:String, onComplete:Function):void
		{
			if (_mapManager != null && _mapManager.username == username  && _mapManager.complete == true)
			{
				onComplete(_mapManager);
			}
			else
			{
				if (_mapManager == null)
				{
					_mapManager = new MapManager(username);
					_mapManager.addEventListener(LoadManager.COMPLETE, onMapComplete);
				}
				_onMapCallback.push(onComplete);
			}
		}
		
		public function getObjects(onComplete:Function):void
		{
			if (_objectManager != null && _objectManager.complete == true)
			{
				onComplete(_objectManager);
			}
			else
			{
				if (_objectManager == null)
				{
					_objectManager = new ObjectManager();
					_objectManager.addEventListener(LoadManager.COMPLETE, onObjectComplete);
				}
				_onObjectCallback.push(onComplete);
			}
		}
		
		public function getTextures(onComplete:Function):void
		{
			if (_textureManager != null && _textureManager.complete == true)
			{
				onComplete(_textureManager);
			}
			else
			{
				if (_textureManager == null)
				{
					_textureManager = new TextureManager();
					_textureManager.addEventListener(LoadManager.COMPLETE, onTextureComplete);
				}
				_onTextureCallBack.push(onComplete);
			}
		}
		
		public function getModels(onComplete:Function):void
		{
			if (_modelManager != null && _modelManager.complete == true)
			{
				onComplete(_modelManager);
			}
			else
			{
				if (_modelManager == null)
				{
					_modelManager = new ModelManager();
					_modelManager.addEventListener(LoadManager.COMPLETE, onModelComplete);
				}
				_onModelCallback.push(onComplete);				
			}
		}
		public function getSignedInUser(onComplete:Function):void
		{
			if (_myUser != null && _myUser.complete == true)
			{
				onComplete(_myUser);
			}
			else
			{
				if (_myUser == null)
				{
					_myUser = new UserManager();
					_myUser.addEventListener(LoadManager.COMPLETE, onSignedInUserComplete);
				}
				_onSignedInUserCallback.push(onComplete);				
			}
		}
		
		private function onSignedInUserComplete(e:Event):void 
		{
			_myUser.removeEventListener(LoadManager.COMPLETE, onSignedInUserComplete);
			
			for (var i:int; i < _onSignedInUserCallback.length; i++)
			{
				_onSignedInUserCallback[i](_myUser);
			}
			_onSignedInUserCallback = new Vector.<Function>();
		}
		
		private function onModelComplete(e:Event):void 
		{
			_modelManager.removeEventListener(LoadManager.COMPLETE, onModelComplete);
			for (var i:int; i < _onModelCallback.length; i++)
			{
				_onModelCallback[i](_modelManager);
			}
			_onModelCallback = new Vector.<Function>();
		}
		
		private function onObjectComplete(e:Event):void 
		{
			_objectManager.removeEventListener(LoadManager.COMPLETE, onObjectComplete);
			
			for (var i:int; i < _onObjectCallback.length; i++)
			{
				_onObjectCallback[i](_objectManager);
			}
			_onObjectCallback = new Vector.<Function>();
		}
		
		private function onMapComplete(e:Event):void 
		{
			_mapManager.removeEventListener(LoadManager.COMPLETE, onModelComplete);
			
			for (var i:int; i < _onMapCallback.length; i++)
			{
				_onMapCallback[i](_mapManager);
			}
			_onMapCallback = new Vector.<Function>();
		}
		
		private function onTextureComplete(e:Event):void 
		{
			_textureManager.removeEventListener(LoadManager.COMPLETE, onModelComplete);

			for (var i:int; i < _onTextureCallBack.length; i++)
			{
				_onTextureCallBack[i](_textureManager);
			}
			_onTextureCallBack = new Vector.<Function>();
		}
	}
}