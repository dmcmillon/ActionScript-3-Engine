package engine.physics.movement 
{
	import engine.math.Vector2D;
	import engine.math.MathHelper;
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class FlightPhysics 
	{
		private var speed:int;
		private var mass:int;
		private var minSpeed:int;
		private var maxSpeed:int;
		private var acceleration:int;
		private var turnSpeed:int;
		private var airDrag:Number;
		private var force:int;
		
		protected var rotation:Number;
		protected var velocity:Vector2D
		
		public function set MinSpeed(minSpeed:int):void
		{
			this.minSpeed = minSpeed;
		}
		
		public function set MaxSpeed(maxSpeed:int):void
		{
			this.maxSpeed = maxSpeed;
		}
		
		public function set ThrustForce(force:int):void
		{
			this.force = force;
			updateAcceleration();
		}
		
		public function set TurnSpeed(turnSpeed:int):void
		{
			this.turnSpeed = turnSpeed;
		}
		
		public function set AirDrag(airDrag:Number):void
		{
			this.airDrag = airDrag;
		}
		
		public function set Mass(mass:int):void
		{
			if ( mass == 0 )
			{
				throw new Error("Mass cannot equal 0. Dividing by 0 is undefined.");
			}
			
			this.mass = mass;
			
			updateAcceleration();
		}
		
		public function set Rotation(rotation:Number):void
		{
			this.rotation = rotation;
		}
		
		public function set Velocity(velocity:Vector2D):void
		{
			this.velocity = velocity;
			
			speed = velocity.magnitude();
		}
		
		public function get Velocity():Vector2D
		{
			return new Vector2D(velocity.x, velocity.y);
		}
		
		public function FlightPhysics() 
		{
			velocity = new Vector2D();
		}
		
		//TODO: calculate rotation from velocity in addition to passing it in
		public function init(velocity:Vector2D, minSpeed:int = 0, maxSpeed:int = 0, mass:int = 1, thrustForce:int = 0, rotation:int = 0, turnSpeed:int = 0, airDrag:Number = 0.0):void
		{
			if ( mass == 0 )
			{
				throw new Error("Mass cannot equal 0. Dividing by 0 is undefined.");
			}
			
			this.velocity = velocity;
			this.minSpeed = minSpeed;
			this.maxSpeed = maxSpeed;
			this.mass = mass;
			this.force = thrustForce;
			this.rotation = rotation;
			this.turnSpeed = turnSpeed;
			this.airDrag = airDrag;
			
			acceleration = force / mass;
			
			speed = velocity.magnitude();
		}
		
		public var accelerate:Boolean = false;
		
		public function thrust(deltaTime:Number):Vector2D
		{
			if ( accelerate )
			{
				speed += acceleration * deltaTime;
			}
			
			speed -= speed * airDrag;
			speed = MathHelper.clampI(speed, minSpeed, maxSpeed);
				
			velocity.normalize();
			velocity.multiply(speed);
			
			return velocity; 
		}
		
		public function decelerate(deltaTime:Number):Vector2D
		{
			return Vector2D.zero();
		}
		
		public function turn(deltaTime:Number):Number 
		{ 
			rotation += turnSpeed * deltaTime;
			orientVelocity();
			return rotation;
		}
		
		private function orientVelocity():void
		{
			velocity.x = -Math.sin(MathHelper.degreesToRadians(-rotation));
			velocity.y = -Math.cos(MathHelper.degreesToRadians(-rotation));
		}
		
		private function updateAcceleration():void
		{
			acceleration = force / mass;
		}
	}
}