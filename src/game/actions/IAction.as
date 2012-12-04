package game.actions 
{
	import game.TileEngine;
	
	/**
	 * ...
	 * <b>Copyright 2011</b>, Frank Bos. All rights reserved.
	 * Frank Bos permits you to use and modify this file. As long as this copyright notice will stay intact.
	 * @author Automaticoo
	 */
	public interface IAction 
	{
		function doAction(tileEngine:TileEngine):void;
		function undo(tileEngine:TileEngine):void;
	}	
}