package assets 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Vector3D;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class ModelManager extends URLLoader 
	{
		private var _models:Vector.<Model>;
		
		private var _modelsLoaded:int = 0;
		
		private var _complete:Boolean = false;
		
		public function ModelManager() 
		{
			super(new URLRequest("objects.xml"));
			
			addEventListener(Event.COMPLETE, onComplete);
		}		
		
		private function onComplete(e:Event):void
		{
			removeEventListener(Event.COMPLETE, onComplete);
			
			var xml:XML = new XML(e.target.data);
			
			_models = new Vector.<Model>();
			
			for each(var item:XML in xml.object.objects.group)
			{
				for each(var item2:XML in item.object)
				{
					var model:Model = new Model(item2, item.@name);
						model.addEventListener(Event.COMPLETE, modelComplete);
					_models.push(model);
				}
			}
		}
		
		public function getModelByID(id:int):Model
		{
			for (var i:int; i < _models.length; i++)
			{
				if (_models[i].id == id)
				{
					return _models[i];
				}
			}
			return null;
		}
		
		private function modelComplete(e:Event):void 
		{
			_modelsLoaded++;
			
			if (_modelsLoaded >= _models.length)
			{
				_complete = true;
				dispatchEvent(new Event(LoadManager.COMPLETE));
			}
		}
		
		public function get complete():Boolean 
		{
			return _complete;
		}
		
		public function get models():Vector.<Model> 
		{
			return _models;
		}
	}
}