package engine.weaponsystem 
{
	import engine.math.Vector2D;
	import engine.miscellaneous.ITickable;
	import engine.physics.Projectile;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class AbstractBullet extends MovieClip implements ITickable
	{
		protected var motion:Projectile;
		
		public function AbstractBullet() 
		{
			
		}
		
		public function tick(deltaTime:Number):void
		{
			
		}
		
		public function init(position:Vector2D, velocity:Vector2D):void
		{
			
		}
	}
}