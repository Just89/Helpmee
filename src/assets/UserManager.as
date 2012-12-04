package assets 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class UserManager extends URLLoader
	{
		private var _complete:Boolean = false;
		
		private var _socialID:int;
		private var _socialDatabaseID:int;
		private var _userDatabaseID:int;
		private var _name:String;
		private var _gender:String;
		private var _statistics:Statistics;
		
		public function UserManager() 
		{
			super(new URLRequest("user.xml"));
			
			addEventListener(Event.COMPLETE, onComplete);
			
		}		
		
		private function onComplete(e:Event):void 
		{
			var xml:XML = new XML(e.target.data);
			
			_name 					= xml.object.user.name;
			
			if (_name != "")
			{
				_socialID 				= xml.object.user.social_id;
				_socialDatabaseID 		= xml.object.user.social_db_id;
				_userDatabaseID 		= xml.object.user.user_db_id;
			
				_gender 				= xml.object.user.gender;
				_statistics				= new Statistics(xml.object.user.stats[0]);
			}			
			
			_complete = true;
			
			dispatchEvent(new Event(LoadManager.COMPLETE));
		}
		
		public function get complete():Boolean 
		{
			return _complete;
		}
		
		public function get socialID():int 
		{
			return _socialID;
		}
		
		public function get socialDatabaseID():int 
		{
			return _socialDatabaseID;
		}
		
		public function get userDatabaseID():int 
		{
			return _userDatabaseID;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get gender():String 
		{
			return _gender;
		}
		
		public function get statistics():Statistics 
		{
			return _statistics;
		}
	}
}