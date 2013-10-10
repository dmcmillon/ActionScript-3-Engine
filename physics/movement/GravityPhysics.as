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
		
		public function GravityPhysics()
		{
			velocity = Vector2D.zero();
		}
		
		public function get Velocity():Vector2D
		{
			return velocity;
		}
		
		public function init(initialVelocity:Vector2D):void
		{
			velocity = initialVelocity;
		}
		
		public function accelerate(currentPosition:Vector2D, mass:Number, position:Vector2D, deltaTime:Number):Vector2D
		{
			var ToVector:Vector2D = position.subtract(currentPosition);
			var distance:Number = ToVector.magnitude();
			
			ToVector.normalize();
			
			var acceleration:Vector2D = ToVector.multiply(gravitationalConstant * mass / distance * distance);
			
			velocity = velocity.add(acceleration.multiply(deltaTime));
			velocity.normalize();
			velocity = velocity.multiply(4);
			
			return velocity;
		}
	}
}