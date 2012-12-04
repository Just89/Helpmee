package ui.tabs 
{
	import assets.LoadManager;
	import assets.Model;
	import assets.ModelManager;
	import events.ObjectEvent;
	import flash.events.Event;
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class HouseTab extends BaseTab 
	{
		
		public function HouseTab() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onStage);
			
			LoadManager.instance.getModels(onModelsLoaded);
		}
		
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			stage.addEventListener(ObjectEvent.PLACE, onPlaced);
		}
		
		private function onPlaced(e:Event):void 
		{
			if (_selectedItem != null)
			{
				_selectedItem.selected = false;
				onDeselect(_selectedItem);
				_selectedItem = null;
			}			
		}
		
		private function onModelsLoaded(modelManager:ModelManager):void 
		{
			for (var i:int; i < modelManager.models.length; i++)
			{
				if (Model(modelManager.models[i]).category == "Huizen")
				{
					var modelItem:ModelItem = new ModelItem(modelManager.models[i]);
					addItem(modelItem);
				}				
			}
		}
		
		override protected function onSelect(item:Item):void
		{
			dispatchEvent(new ObjectEvent(ObjectEvent.SELECTED, ModelItem(item).model.id, true));
		}
		
		override protected function onDeselect(item:Item):void
		{
			dispatchEvent(new ObjectEvent(ObjectEvent.DESELECTED, -1, true));
		}
	}

}