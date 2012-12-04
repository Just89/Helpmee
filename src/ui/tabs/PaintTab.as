package ui.tabs 
{
	import assets.LoadManager;
	import assets.TextureManager;
	import events.TextureEvent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class PaintTab extends BaseTab 
	{		
		public function PaintTab() 
		{
			super();
			LoadManager.instance.getTextures(onTexturesLoaded);
		}
		
		private function onTexturesLoaded(textureManager:TextureManager):void 
		{			
			for (var i:int; i < textureManager.textures.length; i++)
			{
				var paintItem:PaintItem = new PaintItem(textureManager.textures[i]);
				
				addItem(paintItem);
			}
		}
		
		override protected function onSelect(item:Item):void
		{
			dispatchEvent(new TextureEvent(TextureEvent.SELECTED, PaintItem(item).texture.id, null, true));
		}
		
		override protected function onDeselect(item:Item):void
		{
			dispatchEvent(new TextureEvent(TextureEvent.DESELECTED, -1, null, true));
		}
	}
}