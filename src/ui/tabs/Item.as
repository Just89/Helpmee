package ui.tabs 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class Item extends Sprite 
	{
		private var _selected:Boolean;
		
		public function Item() 
		{
			
		}
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			
			if (_selected == true)
			{
				graphics.beginFill(0x0000FF);
				graphics.drawRect( -1, -1, 66, 66);
				graphics.endFill();
			}
			else
			{
				graphics.clear();
			}
		}
	}
}