package engine.miscellaneous 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	/**
	 * Camera used to create camera shake effects. Currently the camera is stationary.
	 * @author Daniel McMillon
	 */
	public class Camera 
	{
		private var scene:DisplayObject;
		
		private var shakeSpeed:Number;
		private var shakeTime:Number;
		
		private var timer:Number;
		
		private var shaking:Boolean = false;
		
		private var sceneLocation:Point;		
		private var cameraLocation:Point;
		
		public function Camera(scene:DisplayObject) 
		{
			this.scene = scene;
			
			sceneLocation = new Point(scene.x, scene.y);
			cameraLocation = new Point(scene.x, scene.y);
		}
		
		public function tick(deltaTime:Number):void
		{
			if ( shaking )
			{
				applyShake(deltaTime);
			}
		}
		
		public function shake(speed:Number, time:Number):void
		{
			shakeSpeed = speed;
			shakeTime = time;
			
			timer = 0;
			
			shaking = true;
		}
		
		private var angle:Number = 0;
		
		private function applyShake(deltaTime:Number):void
		{
			angle += 10;
			timer += deltaTime;
			
			if ( timer < shakeTime )
			{
				cameraLocation.x = sceneLocation.x + randomNumber() * shakeSpeed * deltaTime;
				cameraLocation.y = sceneLocation.y + randomNumber() * shakeSpeed * deltaTime;
				
				scene.x = cameraLocation.x;
				scene.y = cameraLocation.y;
			}
			else
			{
				shaking = false;
				
				scene.x = 0;
				scene.y = 0;
			}
		}
		
		private function randomNumber():Number
		{
			return Math.random() - Math.random();
		}
	}
}