package ui.tabs 
{
	import assets.Model;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class ModelItem extends Item 
	{
		private var _bitmap:Bitmap;
		private var _model:Model;
		
		public function ModelItem(model:Model) 
		{
			this._model = model;
			
			_bitmap = new Bitmap(_model.icon);
			
			addChild(_bitmap);
		}
		
		public function get model():Model 
		{
			return _model;
		}
	}
}