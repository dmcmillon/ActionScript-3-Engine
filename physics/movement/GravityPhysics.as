package engine.physics.movement
{
	import engine.maths.Vector2D;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class GravityPhysics
	{
		private var gravitationalConstant:Number = 0.0015;
		private var velocity:Vector2D;
		private var maxVelocity:Number;
		
		public function GravityPhysics()
		{
			velocity = Vector2D.zero();
		}
		
		public function get Velocity():Vector2D
		{
			return velocity;
		}
		
		public function init(initialVelocity:Vector2D, maxVelocity:Number):void
		{
			velocity = initialVelocity;
			this.maxVelocity = maxVelocity;
		}
		
		public function accelerate(currentPosition:Vector2D, mass:Number, position:Vector2D, deltaTime:Number):Vector2D
		{
			var ToVector:Vector2D = position.subtract(currentPosition);
			var distance:Number = ToVector.magnitude();
			
			ToVector.normalize();
			
			var acceleration:Vector2D = ToVector.multiply(gravitationalConstant * mass / distance * distance);
			
			velocity = velocity.add(acceleration.multiply(deltaTime));
			velocity.normalize();
			velocity = velocity.multiply(maxVelocity);
			
			return velocity;
		}
	}
}