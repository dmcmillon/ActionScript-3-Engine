package engine.weaponsystem 
{
	import engine.math.Vector2D;
	import engine.math.MathHelper;
	import engine.miscellaneous.ITickable;
	import engine.physics.Projectile;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class AbstractBullet extends Sprite implements ITickable
	{
		public static const BULLET_DESTROYED:String = "bulletDestroyed";
		
		protected var image:Sprite;
		protected var motion:Projectile;
		protected var explosionRadius:Number;
		protected var damage:int;
		protected var lifetime:Number;
		protected var bulletSpeed:Number;
		private var timeLived:Number;
		
		
		public function get Damage():int
		{
			return damage;
		}
		
		public function AbstractBullet()
		{
			
		}
		
		public function tick(deltaTime:Number):void
		{
			motion.tick(deltaTime);
			
			x = motion.Position.x;
			y = motion.Position.y;
			
			timeLived += deltaTime;
			
			if ( timeLived > lifetime )
			{
				dispatchEvent(new Event(BULLET_DESTROYED));
			}
		}
		
		public function init(position:Vector2D, velocity:Vector2D):void
		{
			timeLived = 0.0;
			
			velocity = velocity.multiply(bulletSpeed);
			motion = new Projectile(position, velocity, velocity.magnitude(), Vector2D.zero());
			x = position.x;
			y = position.y;
			
			//Get rotation from initial velocity
			rotation = MathHelper.radiansToDegrees(Math.atan2(velocity.y, velocity.x));
		}
		
		public function teardown():void
		{
			motion = null;
		}
	}
}