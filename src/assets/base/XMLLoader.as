package assets.base 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	
	/**
	 * ...
	 * <b>Copyright 2011</b>, Frank Bos. All rights reserved.
	 * Frank Bos permits you to use and modify this file. As long as this copyright notice will stay intact.
	 * @author Automaticoo
	 */
	public class XMLLoader extends URLLoader 
	{		
		public function XMLLoader() 
		{
			addEventListener(Event.COMPLETE, onLoadComplete);
			addEventListener(IOErrorEvent.IO_ERROR, onError);
			
			super();
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			trace("Error loading xml : " + e);
			removeEventListener(Event.COMPLETE, onLoadComplete);
			removeEventListener(IOErrorEvent.IO_ERROR, onError);
		}
		
		private function onLoadComplete(e:Event):void 
		{
			var xml:XML = new XML(e.target.data);
			
			removeEventListener(Event.COMPLETE, onLoadComplete);
			removeEventListener(IOErrorEvent.IO_ERROR, onError);
			
			finishedLoading(xml);
		}
		
		protected function finishedLoading(xml:XML):void
		{
			
		}
	}
}