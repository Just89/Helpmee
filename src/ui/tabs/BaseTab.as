package ui.tabs 
{
	import com.bit101.components.HScrollBar;
	import com.bit101.components.HSlider;
	import com.bit101.components.Panel;
	import com.greensock.easing.Bounce;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class BaseTab extends Sprite 
	{
		private const VISIBLE_HEIGHT:int = 80;
		private const VISIBLE_WIDTH:int = 760;
		private const PADDING:int = 10;
		
		private var _scrollBar:HScrollBar;
		
		private var _scrollContent:Sprite = new Sprite();
		
		private var _cachedScrollRect:Rectangle;
		
		private var _items:Vector.<Item> = new Vector.<Item>();
		protected var _selectedItem:Item;
		
		public function BaseTab() 
		{
			_scrollBar = new HScrollBar(this, 0, 0, onScroll);
			_scrollBar.y = 70;
			_scrollBar.setSliderParams(0, 100, 0);
			_scrollBar.width = VISIBLE_WIDTH;
			
			_scrollContent.cacheAsBitmap = true;
			addChild(_scrollContent);
			//addChild(_scrollBar);
			
			_scrollContent.scrollRect = new Rectangle(0, 0, VISIBLE_WIDTH, VISIBLE_HEIGHT);
			_cachedScrollRect = _scrollContent.scrollRect;
			
			_scrollBar.setThumbPercent(_scrollContent.scrollRect.width / (_scrollContent.width + PADDING*2));
			_scrollBar.maximum = _scrollContent.width - _scrollContent.scrollRect.width + PADDING*2;
			_scrollBar.pageSize = 100;
			_scrollBar.lineSize = 100;
		}
		
		public function addItem(item:Item):void
		{
			item.x = 4 + _items.length * (item.width + 5);
			item.y = 4;
			
			_scrollContent.addChild(item);
			
			item.addEventListener(MouseEvent.CLICK, onClick);
			
			_items.push(item);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			var clickedItem:Item = e.currentTarget as Item;
			
			if (_selectedItem == clickedItem)
			{
				clickedItem.selected = false;
				_selectedItem = null;
				onDeselect(_selectedItem);
			}			
			else if (_selectedItem != null)
			{
				_selectedItem.selected = false;
				clickedItem.selected = true;
				_selectedItem = clickedItem;
				onSelect(_selectedItem);
			}
			else{
			
				clickedItem.selected = true;
				_selectedItem = clickedItem;
				onSelect(_selectedItem);
			}
		}
		
		protected function onSelect(item:Item):void
		{
			
		}
		
		protected function onDeselect(item:Item):void
		{
			
		}
		
		private function onScroll(event:Event):void
		{
			TweenLite.to(_cachedScrollRect, 1, { x:_scrollBar.value, onUpdate:updateScrollRect, ease:Bounce.easeOut } );
		}
		
		private function updateScrollRect():void 
		{
			_scrollContent.scrollRect = _cachedScrollRect;
		}
	}
}