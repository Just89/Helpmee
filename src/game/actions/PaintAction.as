package game.actions 
{
	import game.data.Tile;
	import game.TileEngine;
	/**
	 * ...
	 * <b>Copyright 2011</b>, Frank Bos. All rights reserved.
	 * Frank Bos permits you to use and modify this file. As long as this copyright notice will stay intact.
	 * @author Automaticoo
	 */
	public class PaintAction implements IAction 
	{
		private var _x:int;
		private var _y:int;
		private var _id:int;
		private var _oldId:int;
		
		public function PaintAction(x:uint, y:uint, id:uint) 
		{
			_id = id;
			_y = y;
			_x = x;
		}
		
		public function doAction(tileEngine:TileEngine):void
		{
			_oldId = tileEngine.getTile(_x, _y).textureID;
			tileEngine.getTile(_x, _y).textureID = _id;
		}
		
		public function undo(tileEngine:TileEngine):void
		{
			tileEngine.getTile(_x, _y).textureID = _oldId;
		}
	}
}