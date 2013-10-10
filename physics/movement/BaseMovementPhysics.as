package engine.physics.movement 
{
	import engine.maths.Vector2D;
	/**
	 * Outputs a net force.
	 * @author Daniel McMillon
	 */
	public class BaseMovementPhysics 
	{
		public var maxSpeed:Number;
		public var acceleration:Number;
		public var rotationSpeed:Number;
		public var friction:Number;
		
		protected var rotation:Number;
		
		protected var velocity:Vector2D;
		protected var speed:Number;
		
		public function get Rotation():Number
		{
			return rotation;
		}
		
		public function BaseMovementPhysics() 
		{
			speed = 0.0;
			maxSpeed = 0.0;
			acceleration = 0.0;
			rotation = 0.0;
			friction = 0.0;
			
			velocity = new Vector2D();
		}
		
		public function init(speed:Number, maxSpeed:Number, acceleration:Number, velocity:Vector2D, rotation:Number, rotationSpeed:Number, friction:Number):void
		{
			this.speed = speed;
			this.maxSpeed = maxSpeed;
			this.acceleration = acceleration;
			this.rotation = rotation;
			this.rotationSpeed = rotationSpeed;
			this.friction = friction;
			this.velocity = velocity;
		}
		
		public function accelerate(deltaTime:Number):Vector2D { return Vector2D.zero(); }
		public function decelerate(deltaTime:Number):Vector2D { return Vector2D.zero(); }
		public function right(deltaTime:Number):Vector2D { return Vector2D.zero(); }
		public function left(deltaTime:Number):Vector2D { return Vector2D.zero(); }
		public function reverse(deltaTime:Number):Vector2D { return Vector2D.zero(); }
		public function turnRight(deltaTime:Number):Number { return 0.0; }
		public function turnLeft(deltaTime:Number):Number { return 0.0; }
	}
}