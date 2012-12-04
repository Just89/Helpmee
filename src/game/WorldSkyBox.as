package game 
{
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.Material;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.SkyBox;
	import alternativa.engine3d.primitives.Box;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import game.shapes.Plane;
	
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class WorldSkyBox extends SkyBox
	{
		[Embed(source = '../../lib/skybox2/front.png')]
		private var FRONT:Class;			
		[Embed(source = '../../lib/skybox2/back.png')]
		private var BACK:Class;		
		[Embed(source = '../../lib/skybox2/left.png')]
		private var LEFT:Class;
		[Embed(source = '../../lib/skybox2/right.png')]
		private var RIGHT:Class;
		[Embed(source = '../../lib/skybox2/top.png')]
		private var UP:Class;
		[Embed(source = '../../lib/skybox2/bottom.png')]
		private var DOWN:Class;
		
		public function WorldSkyBox() 
		{
			var leftBitmapTexture:BitmapTextureResource = new BitmapTextureResource(new LEFT().bitmapData);
			var leftTextureMaterial:TextureMaterial = new TextureMaterial(leftBitmapTexture);
			
			var rightBitmapTexture:BitmapTextureResource = new BitmapTextureResource(new RIGHT().bitmapData);
			var rightTextureMaterial:TextureMaterial = new TextureMaterial(rightBitmapTexture);
			
			var upBitmapTexture:BitmapTextureResource = new BitmapTextureResource(new UP().bitmapData);
			var upTextureMaterial:TextureMaterial = new TextureMaterial(upBitmapTexture);
			
			var downBitmapTexture:BitmapTextureResource = new BitmapTextureResource(new DOWN().bitmapData);
			var downTextureMaterial:TextureMaterial = new TextureMaterial(downBitmapTexture);
				
			var frontBitmapTexture:BitmapTextureResource = new BitmapTextureResource(new FRONT().bitmapData);
			var frontTextureMaterial:TextureMaterial = new TextureMaterial(frontBitmapTexture);
			
			var backBitmapTexture:BitmapTextureResource = new BitmapTextureResource(new BACK().bitmapData);
			var backTextureMaterial:TextureMaterial = new TextureMaterial(backBitmapTexture);
			
			super(5000, leftTextureMaterial, rightTextureMaterial, backTextureMaterial, frontTextureMaterial, upTextureMaterial, downTextureMaterial, 0.001);
		}
	}
}