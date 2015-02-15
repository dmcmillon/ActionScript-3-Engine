package engine.weaponsystem 
{
	import engine.math.Vector2D;
	import engine.miscellaneous.ITickable;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class AbstractFiringWeapon extends Sprite implements ITickable
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
		
		public function fire():void
		{
			if ( fireTimer >= fireRate && (infiniteAmmo || numBullets > 0) )
			{
				shoot();
				fireTimer = 0;
			}
		}
		
		protected function shoot():void
		{
			
		}
		
		public function teardown():void
		{
			
		}
	}
}