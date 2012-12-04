package game.actions 
{
	import flash.display.NativeMenuItem;
	/**
	 * ...
	 * @author Just
	 */
	public class ObjectAction implements IAction
	{
		private var _x:uint;
		private var _y:uint;
		private var _id:uint;
		
		public function ObjectAction(x:uint, y:uint, id:uint) 
		{
			_id = id;
			_y = y;
			_x = x;
		}
		
		public function doAction():void
		{
			
		}
		
		public function unDo():void
		{
			
		}
		
	}

}