package assets 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class Statistics extends EventDispatcher
	{
		private var _cash:int;
		private var _population:int;
		private var _happiness:int;
		private var _xp:int;
		
		public function Statistics(xml:XML) 
		{
			_cash = xml.cash;
			_population = xml.population;
			_xp = xml.xp;
			_happiness = xml.happiness;
		}		
		
		public function get population():int 
		{
			return _population;
		}
		
		public function get happiness():int 
		{
			return _happiness;
		}
		
		public function get xp():int 
		{
			return _xp;
		}
		
		public function get cash():int 
		{
			return _cash;
		}
		
		public function set cash(value:int):void 
		{
			_cash = value;
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}