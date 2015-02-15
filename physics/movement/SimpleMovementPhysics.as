package engine.physics.movement 
{
	import engine.math.MathHelper;
	import engine.math.Vector2D;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class SimpleMovementPhysics extends BaseMovementPhysics
	{
		public function SimpleMovementPhysics() 
		{
			super();
		}
		
		//outputs the new position
		public override function accelerate(deltaTime:Number):Vector2D
		{
			speed += acceleration * deltaTime;
			
			if (speed >= maxSpeed)
			{
				speed = maxSpeed;
			}
			
			findHeading();
			scaleVelocity(deltaTime);
			applyFriction(deltaTime);
			
			return velocity;
		}
		
		public override function decelerate(deltaTime:Number):Vector2D
		{
			if ( speed > 0.0 ) 
			{
				speed -= acceleration * deltaTime;
				applyFriction(deltaTime)
			}
			
			return velocity;
		}
		
		public override function turnRight(deltaTime:Number):Number
		{
			rotation += rotationSpeed * deltaTime;
			
			return rotation;
		}
		
		public override function turnLeft(deltaTime:Number):Number
		{
			rotation -= rotationSpeed * deltaTime;
			
			return rotation;
		}
		
		private function findHeading():void
		{
			velocity.x = Math.sin(MathHelper.degreesToRadians(rotation));
			velocity.y = -Math.cos(MathHelper.degreesToRadians(rotation));
		}
		
		private function scaleVelocity(deltaTime:Number):void
		{			
			velocity.x *= speed * deltaTime;
			velocity.y *= speed * deltaTime;
		}
		
		private function applyFriction(deltaTime:Number):void
		{
			velocity.x -= velocity.x * friction * deltaTime;
			velocity.y -= velocity.y * friction * deltaTime;
		}
	}
}