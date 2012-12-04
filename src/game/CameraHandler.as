package game 
{
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import com.greensock.TweenLite;
	import events.CameraEvent;
	import flash.display.Stage;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author ...
	 */
	public class CameraHandler 
	{
		private var _camera:Camera3D;
		private var _level:Object3D;
		
		private var _localMovement:Vector3D = new Vector3D();
		private var _globalMovement:Vector3D = new Vector3D();
		private var _levelRotation:Number = 0;
		private var _cameraRotation:Number = 0;
		
		public function CameraHandler(camera:Camera3D, stage:Stage, level:Object3D) 
		{
			this._camera = camera;
			this._level = level;
			stage.addEventListener(CameraEvent.CAMERA_MOVE, onMove);
			stage.addEventListener(CameraEvent.CAMERA_STRAFE, onStrafe);
			stage.addEventListener(CameraEvent.CAMERA_ZOOM, onZoom);
			stage.addEventListener(CameraEvent.CAMERA_STOP, onStop);
			stage.addEventListener(CameraEvent.CAMERA_ROTATE, onRotate);
			stage.addEventListener(CameraEvent.CAMERA_PAN, onPan);
			stage.addEventListener(CameraEvent.RESET, onReset);
		}		
		
		private function onReset(e:CameraEvent):void 
		{
			TweenLite.to(_camera, 1, { z:World.DEFAULT_POSITION.z, x:World.DEFAULT_POSITION.x, y:World.DEFAULT_POSITION.y, rotationX:World.DEFAULT_PANNING } );
			TweenLite.to(_level, 1, { rotationZ:0 } );
		}
		
		private function onStop(e:CameraEvent):void 
		{
			_localMovement.x = _localMovement.y = _localMovement.z = 0;
			_globalMovement.x = _globalMovement.y = _globalMovement.z = 0;
			_levelRotation = 0;
			_cameraRotation = 0;
		}
		
		public function update():void
		{
			_camera.y += _globalMovement.y;
			_camera.x += _globalMovement.x;
			_camera.z += _globalMovement.z;
			
			//apply movement in global space to the rotations of the matrix of the camera in local space
			var vector:Vector3D  = _camera.matrix.transformVector(_localMovement); 
			
			//apply the new position to the camera
			_camera.y = vector.y;
			_camera.x = vector.x;
			_camera.z = vector.z;
			
			_level.rotationZ += _levelRotation;
			
			_camera.rotationX += _cameraRotation;
		}
		
		private function onZoom(e:CameraEvent):void 
		{
			_localMovement.z = e.value;
		}
		
		private function onStrafe(e:CameraEvent):void 
		{
			_localMovement.x = e.value;
		}
		
		private function onPan(e:CameraEvent):void 
		{
			_cameraRotation = e.value * 0.0174532925;
		}
		
		private function onMove(e:CameraEvent):void 
		{
			_globalMovement.z = e.value;
		}
		
		private function onRotate(e:CameraEvent):void 
		{
			_levelRotation = e.value * 0.0174532925;
		}		
	}
}