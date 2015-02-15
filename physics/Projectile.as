package engine.physics 
{
	import engine.math.Vector2D;
	import engine.miscellaneous.ITickable;
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class Projectile implements ITickable
	{
		private var position:Vector2D;
		private var velocity:Vector2D;
		private var acceleration:Vector2D;
		
		private var maxSpeed:Number = 0;
		
		private var isGravity:Boolean = false;
		private var gravity:Number = 0.0;
		
		public function get Position():Vector2D
		{
			return position;
		}
		
		public function Projectile(position:Vector2D, velocity:Vector2D, maxSpeed:Number, acceleration:Vector2D) 
		{
			this.position = position;
			this.velocity = velocity;
			this.maxSpeed = maxSpeed;
			this.acceleration = acceleration;
		}
		
		public function applyGravity(gravity:Number):void
		{
			if ( isGravity == false )
			{
				isGravity = true;
				this.gravity = gravity;
				acceleration.y += gravity;
			}
		}
		
		public function removeGravity():void
		{
			if ( isGravity == true )
			{
				isGravity = false;
				acceleration.y -= gravity;
			}
		}
				
		public function tick(deltaTime:Number):void
		{
			//velocity += acceleration * deltaTime
			velocity = velocity.add(acceleration.multiply(deltaTime));
			velocity.truncate(maxSpeed);
			
			position = position.add(velocity.multiply(deltaTime));
		}
	}
}