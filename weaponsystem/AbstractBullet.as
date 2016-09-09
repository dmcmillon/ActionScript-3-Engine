package engine.weaponsystem 
{
	import engine.collision.box.AABB;
	import engine.collision.IBoundingVolume;
	import engine.collision.ICollider;
	import engine.math.Vector2D;
	import engine.math.MathHelper;
	import engine.miscellaneous.ITickable;
	import engine.physics.Projectile;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class AbstractBullet implements IBullet
	{
		private var sprite:Sprite;
		
		private var motion:Projectile;
		
		public var aabb:AABB;
		
		private var _damage:int;
		public var lifetime:Number;
		public var bulletSpeed:Number;
		
		private var timeLived:Number;
		
		private var alive:Boolean;
		
		public function get damage():int
		{
			return _damage;
		}
		
		public function set damage(value:int):void
		{
			_damage = value;
		}
		
		public function AbstractBullet(sprite:Sprite)
		{
			this.sprite = sprite;
		}
		
		public function isAlive():Boolean
		{
			return alive;
		}
		
		public function tick(deltaTime:Number):void
		{
			motion.tick(deltaTime);
			
			sprite.x = motion.Position.x;
			sprite.y = motion.Position.y;
			
			timeLived += deltaTime;
			
			if ( timeLived > lifetime )
			{
				destroyBullet();
			}
		}
		
		public function init(position:Vector2D, rotation:Number):void
		{
			timeLived = 0.0;
			
			position.x += sprite.width / 2;
			
			var velocity:Vector2D = new Vector2D(Math.cos(MathHelper.degreesToRadians(rotation)), Math.sin(MathHelper.degreesToRadians(rotation)));
			velocity.normalize();
			
			velocity = velocity.multiply(bulletSpeed);
			motion = new Projectile(position, velocity, velocity.magnitude(), Vector2D.zero());
			sprite.x = position.x;
			sprite.y = position.y;
			
			sprite.rotation = rotation;
			
			alive = true;
			
			aabb = new AABB(sprite, new Point(-sprite.width/2, -sprite.height/2), new Point(sprite.width/2, sprite.height/2));
		}
		
		public function getBoundingVolume():IBoundingVolume
		{
			return aabb;
		}
		
		public function onCollision(collider:ICollider):void
		{
			
		}
		
		public function destroyBullet():void
		{
			sprite.parent.removeChild(sprite);
			alive = false;
		}
	}
}