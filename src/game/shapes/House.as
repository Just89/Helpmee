package game.shapes
{
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.primitives.Box;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * <b>Copyright 2011</b>, Frank Bos. All rights reserved.
	 * Frank Bos permits you to use and modify this file. As long as this copyright notice will stay intact.
	 * @author Automaticoo
	 */
	public class House extends Object3D 
	{
		private var _ground:Vector.<Point>;
		private var _levels:Vector.<Vector3D>;
		private var _roof:String;
		private var _walls:Vector.<Point>;
		
		public function House(str:String = "")
		{
			//this.rotationX =  Math.PI + Math.PI/2;
			formatData(str);
			buildHouse();
		}
		
		private function buildHouse():void 
		{
			/*var colors:Array = [0x80FF00, 0x0000FF, 0xFFFF00, 0xFF0000];
			for (var i:int; i < _walls.length; i += 2)
			{
				var pos1:Point = _walls[i];
				var pos2:Point = _walls[i + 1];
				var angle:Number = Math.atan2(pos2.y - pos1.y, pos2.x - pos1.x);
				var plane:Plane = new Plane(new FillMaterial(colors[i/2]), 64, 100, 1, 1);
					plane.x = pos1.x;
					plane.z = pos1.y;
					if (angle == 1.5707963267948966 || angle == -1.5707963267948966 )
					{
						angle = -angle;
					}
					plane.rotationY = angle;
					plane.rotationX = Math.PI;
					plane.z -= 100;
				addChild(plane);
			}*/
			for (var i:int; i < _ground.length; i++)
			{
				var pos:Point = _ground[i];
				var box:Box = new Box(64, 64, 64, 1, 1, 1, false, new FillMaterial(0x0080C0));
					box.x = pos.x * 64;
					box.z = pos.y * 64;
				addChild(box);	
			}
			for (i = 0; i < _levels.length; i++ )
			{
				var vec:Vector3D = _levels[i];
					box = new Box(64, 64, 64, 1, 1, 1, false, new FillMaterial(0x0080C0));
					box.x = vec.x * 64;
					box.z = vec.y * 64;
					box.y = vec.z * 64;
				addChild(box);
			}
		}
		
		public function formatData(str:String):void
		{
			_walls = new Vector.<Point>();
			_ground = new Vector.<Point>();
			_levels = new Vector.<Vector3D>();
			
			//Walls:{x:0y:0x:0y:100}, {x:0y:100x:100y:100}, {x:100 y:100 x:100y:0}, {x:100y:0x:0y:0}
			//str = "Walls:0,0, 0,100,	0,100, 100,100,		100,100, 100,0,		100,0,0,0		|";
			str = "Ground:0,0, 0,1, 1,0, 1,1, 3,3|";
			str += "Level:0,0,1, 0,1,1, 1,0,1, 1,1,1|";
			str += "Roof:flat|";
			str += "Levels:1|";
			
			str = str.split(" ").join("").split("\t").join("");
			
			/*
			var walls:Array = stringToArray(str, "Walls:");
			
			for (var i:int; i < walls.length; i += 4)
			{
				_walls.push(new Point(walls[i], walls[i + 1]));
				_walls.push(new Point(walls[i + 2], walls[i + 3]));
			}
			*/
			
			var ground:Array = stringToArray(str, "Ground:");
			var levels:Array = stringToArray(str, "Level:");
			
			for (var i:int = 0; i < ground.length; i += 2)
			{
				_ground.push(new Point(ground[i], ground[i + 1]));
			}
			
			for (i = 0; i < levels.length; i += 3)
			{
				_levels.push(new Vector3D(levels[i], levels[i + 1], levels[i + 2]));
			}
		}
		
		public function stringToArray(str:String, identifier:String):Array
		{
			var begin:int = str.indexOf(identifier) + identifier.length;
			var end:int = str.indexOf("|", begin);
			var elements:String = str.substring(begin, end);
			return elements.split(",");
		}
	}
}