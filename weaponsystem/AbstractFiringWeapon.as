package engine.weaponsystem 
{
	import engine.events.BulletCreatedEvent;
	import engine.math.Vector2D;
	import engine.math.MathHelper;
	import engine.miscellaneous.ITickable;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import game.world.GameWorld;
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class AbstractFiringWeapon extends Sprite implements ITickable
	{		
		protected var numBullets:int;
		protected var maxBullets:int;
		
		protected var fireRate:Number;
		protected var fireTimer:Number = 0.0;
		
		protected var infiniteAmmo:Boolean;
				
		protected var bulletOffset:Vector2D;
		
		public function get isAmmoInfinite():Boolean
		{
			return infiniteAmmo;
		}
		
		public function AbstractFiringWeapon(fireRate:Number, maxBullets:int = -1,  numBullets:int = -1) 
		{
			this.numBullets = numBullets;
			this.fireRate = fireRate;
			this.maxBullets = maxBullets;
			
			infiniteAmmo = (maxBullets <= 0);
			
			if ( numBullets < 0 )
			{
				this.numBullets = maxBullets;
			}
			
			bulletOffset = Vector2D.zero();
		}
		
		public function setup():void
		{
			fireTimer = 0.0;
		}
		
		public function tick(deltaTime:Number):void
		{
			fireTimer += deltaTime;
		}
		
		public function possibleAmmoToAdd():int
		{
			return maxBullets - numBullets;
		}
		
		public function addAmmo(amount:int):void
		{
			var additionalAmmo:int = (maxBullets - numBullets < amount) ? maxBullets - numBullets : amount;
			
			numBullets += maxBullets;
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
			position.addToVector(bulletOffset);
			
			var bullet:IBullet = createBullet();
			bullet.init(position, rotationAngle);
			
			var bulletCreatedEvent:BulletCreatedEvent = new BulletCreatedEvent(BulletCreatedEvent.BULLET_CREATED);
			bulletCreatedEvent.bullet = bullet;
			
			numBullets--;
			
			dispatchEvent(bulletCreatedEvent);
		}
		
		protected function createBullet():IBullet
		{
			return null;
		}
		
		public function teardown():void
		{
			
		}
	}
}