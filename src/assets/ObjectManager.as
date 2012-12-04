package assets 
{
	import alternativa.engine3d.core.Object3D;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Vector3D;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class ObjectManager extends URLLoader
	{
		private var _complete:Boolean = false;
		
		private var _objects:Vector.<Object3D>;
		
		public function ObjectManager() 
		{
			addEventListener(Event.COMPLETE, finishedLoading);
			load(new URLRequest("objects.xml"));
		}
		
		private function finishedLoading(e:Event):void 
		{
			_objects = new Vector.<Object3D>();
			
			var xml:XML = new XML(e.target.data);
			
			LoadManager.instance.getModels(function(modelManager:ModelManager):void {
				for each(var item:XML in xml.object.objects.object)
				{
					var model:Model = ModelManager(modelManager).getModelByID(item.@id);
					var object:Object3D = model.model.clone();
						object.x = item.position.@x * 64;
						object.y = item.position.@y * 64;
						object.rotationZ = item.position.@rotation;
					_objects.push(object);
				}
			});
			
			_complete = true;
			dispatchEvent(new Event(LoadManager.COMPLETE));
		}
		
		public function setObject(object:Model, x:int, y:int, rotation:int):void
		{
			
				
			LoadManager.instance.getSignedInUser(function(user:UserManager):void {
					LoadManager.instance.getModels(function(modelManager:ModelManager):void {
						//user.statistics.cash -= textureManager.getTextureByID(tile.textureID).cost;
					});
				} );
		}
		
		private function onChangeServer(e:Event):void 
		{			
			var xml:XML = new XML(e.target.data);
			
			trace(xml);
			
			if (xml.object.floor == "false")
			{
				//var x:int = xml.object.floor.@x;
				//var y:int = xml.object.floor.@y;
				//var id:int = xml.object.floor.@id;
				
				//_tiles[x * tileLength + y].textureID = id;
				
				LoadManager.instance.getSignedInUser(function(user:UserManager):void {
					LoadManager.instance.getModels(function(modelManager:ModelManager):void {
						//user.statistics.cash += textureManager.getTextureByID(tile.textureID).cost;
					});
				} );
				
				
				//TODO error wegdoen xml.error.row
			}
		}
		
		public function get complete():Boolean 
		{
			return _complete;
		}
		
		public function get objects():Vector.<Object3D> 
		{
			return _objects;
		}
	}
}