package game.shapes 
{
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.VertexAttributes;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.Material;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.resources.Geometry;
	
	/**
	 * ...
	 * <b>Copyright 2011</b>, Frank Bos. All rights reserved.
	 * Frank Bos permits you to use and modify this file. As long as this copyright notice will stay intact.
	 * @author Automaticoo
	 * The normal Plane class creates planes out of squares, each square contains two triangles.
	 * The simple Plane class makes 4 vertexes and combines them making 2 indices to create 2 triangles
	 * If you want to increase the height of 1 square (4 vertexes) you don't get a symetrical correct height adjustment
	 * We(Justian, Navid, Remi, Frank) created a SymmetricPlane that contains 4 triangles in each square.
	 * The best representation is a simple drawin
	 *     _____                       _____
	 *    |    /|                     |\   /|  
	 *    |   / |    Instead of       | \ / |    
	 *    | /   |                     | / \ |
     *    |/____|                     |/___\|  
     *     4 vertexes                5 vertexes 
	 *     2 triangles               4 triangles
	 *       
	 */
	public class Plane extends Object3D 
	{
		private var _material:Material;
		private var _width:Number;
		private var _height:Number;
		private var _segmentsW:uint;
		private var _segmentsH:uint;
		
		private var _mesh:Mesh;
		
		private var _geometry:Geometry;
		private var _segmentHeight:Number;
		private var _segmentWidth:Number;
		
		public function Plane(material:Material = null, width:Number = 100, height:Number = 100, segmentsW:uint = 1, segmentsH:uint = 1) 
		{
			_material = material;
			_width = width;
			_height = height;
			_segmentsW = segmentsW;
			_segmentsH = segmentsH;
			super();
			
			buildGeometry();
		}
		
		private function buildGeometry():void
		{
			_mesh = new Mesh();
			
			//define array format, first 3 paramters are positions (x,y,z) then last two are texture coordinates(uv data)
			var attributes:Array = new Array();
				attributes[0] = VertexAttributes.POSITION;
				attributes[1] = VertexAttributes.POSITION;
				attributes[2] = VertexAttributes.POSITION;
				attributes[4] = VertexAttributes.TEXCOORDS[0];
				attributes[5] = VertexAttributes.TEXCOORDS[0];
				attributes[6] = VertexAttributes.NORMAL;
				attributes[7] = VertexAttributes.NORMAL;
				attributes[8] = VertexAttributes.NORMAL;
			
			//create all four arrays that help building the geometry
			var vertices:Vector.<Number>;
			var normals:Vector.<Number>;
			var indices:Vector.<uint>;
			//create a uv texture
			var uvs:Vector.<Number>;
			
			//init a x and y variable so we can use it inside the for loop
			var x:Number;
			var y:Number;
			var uvX:Number;
			var uvY:Number;
			
			//variable used to create all the indicis inside the planes
			var leftTop:int, leftBot:int, rightTop:int, rightBot:int, middle:int;
			
			//(width vertices) * (height vertices) + (middle vertexes)
			var numVerts : uint = ((_segmentsW + 1) * (_segmentsH + 1) + (_segmentsW * _segmentsH));
			//calculate the segments and multiply it by 4 because each face(square) got 4 triangles
			var numInds:uint = _segmentsW * _segmentsH * 4;
			//calculate how many elements the uv array is going to contain
			var numUvs:uint = ((_segmentsW + 1) * (_segmentsH + 1) + (_segmentsW * _segmentsH)) * 2;
			
			var segmentPercentWidth:Number = (1 / _segmentsW);
			var segmentPercentHeight:Number = (1 / _segmentsH) / 2;
			
			vertices = new Vector.<Number>(numVerts * 3, true);
			normals = new Vector.<Number>(numVerts * 3, true);
			indices = new Vector.<uint>(numInds * 3, true);
			uvs = new Vector.<Number>(numUvs, true);
			
			//calculate the width and height used by each individual segment
			_segmentHeight = _width / _segmentsW;
			_segmentWidth = _height / _segmentsH;
			
			//this variable is going to used to counter the number of single loops
			numVerts = 0;
			numUvs = 0;
			
			//2 rows added each face + 1 start row
			var rows:int = _segmentsH * 2 + 1; 
			var columns:int = _segmentsW + 1;
			
			//walk to all rows
			for (var yi:int; yi < rows; yi++)
			{
				//walk to all columns
				for (var xi:int = 0; xi < columns; xi++)
				{
					if (yi % 2 == 1)//if y is middle line (y is uneven)
					{
						if (xi == 0)
						{							
							continue;	//skip first point (middle line got 1 point less)
						}
						//calculate the x variable of our middle point
						x = xi * _segmentWidth - _segmentWidth / 2;
						//calculate the y variable of our middle point
						y = Math.floor(yi * 0.5) * _segmentHeight + _segmentHeight * 0.5;
						
						uvX = (xi * segmentPercentWidth) - (segmentPercentWidth / 2);
						uvY = yi * segmentPercentHeight;
					}
					else
					{
						//calculate the x variable of our middle point
						x = xi * _segmentWidth;
						//calculate the y variable of our middle point
						y = Math.floor(yi * 0.5) * _segmentHeight;
						
						uvX = xi * segmentPercentWidth;
						uvY = yi * segmentPercentHeight;
					}
					
					//use the calculated x and y variables to fill the vertices, normals and tangents array
					
					//x
					vertices[numVerts] = x; 	//set x of the vertices array
					normals[numVerts++] = 0;		//set x of the normals array
					
					//y
					vertices[numVerts] = y;		//set y of the vertices array
					normals[numVerts++] = 0;		//set y of the normals array
					
					//z
					vertices[numVerts] = 0;		//set z of the vertices array
					normals[numVerts++] = -1;		//set z of the normals array
					
					
					uvs[numUvs++] = uvX; //set x of the uvs array and increment to next number (y position)
					uvs[numUvs++] = uvY; //set y of the uvs array and increment to next number (x position of next uv point)
				}
			}
			
			//this variable is going to used to counter the number of single loops
			numInds = 0;
			
			//calcute indices of each face inside the plane
			for (yi = 0; yi < _segmentsW; yi++)
			{
				for (xi = 0; xi < _segmentsH; xi++)
				{
					//calculate all points inside the face(square) so we can define the 4 triangles easily
					leftTop = xi + (_segmentsW + 1 + _segmentsW) * yi;
					leftBot = xi + (_segmentsW + 1 + _segmentsW) * (yi+1);
					rightTop = leftTop + 1;
					rightBot = leftBot + 1;
					middle = (leftBot + leftTop + rightTop + rightBot) * 0.25;					
					
					//set left triangle
					indices[numInds++] = leftTop;	
					indices[numInds++] = leftBot;			
					indices[numInds++] = middle;			
					//set bot triangle
					indices[numInds++] = leftBot;					
					indices[numInds++] = rightBot;		
					indices[numInds++] = middle;
					//set right triangle
					indices[numInds++] = rightBot;	
					indices[numInds++] = rightTop;		
					indices[numInds++] = middle;
					//set top triangle
					indices[numInds++] = rightTop;	
					indices[numInds++] = leftTop;		
					indices[numInds++] = middle;
				}
			}
			
			_geometry = new Geometry();
			_geometry.addVertexStream(attributes);
			_geometry.numVertices = vertices.length/3;
			
			_geometry.setAttributeValues(VertexAttributes.POSITION, vertices);
			_geometry.setAttributeValues(VertexAttributes.TEXCOORDS[0], uvs);
			_geometry.setAttributeValues(VertexAttributes.NORMAL, normals);
			_geometry.indices = indices;
			//_mesh.x = -_width / 2;
			//_mesh.y = -_height / 2;
			
			_mesh.geometry = _geometry;
			_mesh.addSurface(_material, 0, indices.length/3);
			_mesh.calculateBoundBox();
			addChild(_mesh);
		}
		
		public function get material():Material { return _material; }		
		public function set material(value:Material):void 
		{
			_mesh.getSurface(0).material = value;
			_material = value;
		}
		
		public function get segmentsW():uint { return _segmentsW; }		
		public function get segmentsH():uint { return _segmentsH; }
		
		public function get height():Number 
		{
			return _height;
		}
		
		public function get width():Number 
		{
			return _width;
		}
	}
}