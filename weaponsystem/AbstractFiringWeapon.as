package engine.weaponsystem 
{
	import engine.events.BulletCreatedEvent;
	import engine.math.Vector2D;
	import engine.math.MathHelper;
	import engine.miscellaneous.ITickable;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class AbstractFiringWeapon extends EventDispatcher implements ITickable, IEventDispatcher
	{		
		protected var startNumberOfBullets:int;
		protected var numBullets:int;
		protected var maxBullets:int;
		
		protected var fireRate:Number;
		
		protected var infiniteAmmo:Boolean;
		protected var fireTimer:Number = 0;
		
		public function AbstractFiringWeapon(fireRate:Number, numBullets:int = -1, maxBullets:int = -1) 
		{
			this.numBullets = numBullets;
			this.fireRate = fireRate;
			this.maxBullets = maxBullets;
				
			if ( maxBullets < 0 )
			{
				maxBullets = numBullets;
			}
			
			infiniteAmmo = (maxBullets < 0);
		}
		
		public function setup():void
		{
			fireTimer = 0;
		}
		
		public function tick(deltaTime:Number):void
		{
			fireTimer += deltaTime;
		}
		
		public function increaseAmmo(amount:int):void
		{
			
		}
		
		public function fire(weaponPosition:Vector2D, rotationAngle:Number):void
		{
			if ( fireTimer >= fireRate && (infiniteAmmo || numBullets > 0) )
			{
				shoot(weaponPosition, rotationAngle);
				fireTimer = 0;
			}
		}
		
		protected function shoot(weaponPosition:Vector2D, rotationAngle:Number):void
		{
			var position:Vector2D = new Vector2D(weaponPosition.x, weaponPosition.y);
			var rotation:Number = rotationAngle;
			
			var velocity:Vector2D = new Vector2D(Math.cos(MathHelper.degreesToRadians(rotation)), Math.sin(MathHelper.degreesToRadians(rotation)));
			velocity.normalize();
			
			var bullet:AbstractBullet = createBullet();
			position.x += bullet.width / 2;
			bullet.init(position, velocity);
			
			var bulletCreatedEvent:BulletCreatedEvent = new BulletCreatedEvent(BulletCreatedEvent.BULLET_CREATED);
			bulletCreatedEvent.bullet = bullet;
			
			dispatchEvent(bulletCreatedEvent);
		}
		
		protected function createBullet():AbstractBullet
		{
			return new AbstractBullet();
		}
		
		public function teardown():void
		{
			
		}
	}
}