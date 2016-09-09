package engine.collision.circle 
{
	import engine.collision.IBoundingVolume;
	import engine.math.Vector2D;
	import flash.geom.Point;
	/**
	 * Represents a bounding circle and handles collision detection with other bounding circles.
	 * @author Daniel McMillon
	 */
	public class BoundingCircle implements IBoundingVolume
	{
		public var center:Vector2D;
		public var radius:Number;
		
		private var intersectionPoint:Vector2D;
		
		private var drawImage:Boolean = false;
		
		public function BoundingCircle(center:Vector2D, radius:Number) 
		{
			this.center = center;
			this.radius = radius;
			
			intersectionPoint = null;
		}
		
		public function updatePosition(center:Vector2D):void
		{
			this.center.x = center.x;
			this.center.y = center.y;
		}
		
		public function updateRadius(radius:Number):void
		{
			this.radius = radius;
		}
		
		/**
		 * Collision detection function for when only one object is moving.
		 * @param	other		The bounding circle of the object that we are checking against for a collision.
		 * @return				Function returns true if there is a collision detection and false if there is not.
		 */
		public function CircleCircleStaticCollision(other:BoundingCircle):Boolean
		{
			var collision:Boolean = false;
			
			var distance:Number = center.distanceSquared(other.center);
			var radii:Number = (radius + other.radius) * (radius + other.radius);
			
			if ( distance <= radii )
			{
				collision = true;
			}
			
			return collision;
		}
		
		/**
		 * Collision detection function for when both objects are moving.
		 * @param	other			The bounding circle of the object that we are checking against for a collision.
		 * @param	thisVelocity	The velocity of the object that is contained by this bounding circle.
		 * @param	otherVeocity	The velocity of the object that is contained by other bounding circle.
		 * @return					Beginning time of intersection. If there is no intersection function returns -1.
		 */
		public function CircleCircleDynamicCollision(other:BoundingCircle, thisVelocity:Vector2D, otherVelocity:Vector2D):Number
		{
			var radii:Number = radius + other.radius;
			var distance:Vector2D = center.subtract(other.center);
			var direction:Vector2D = otherVelocity.subtract(thisVelocity);
			var distanceTraveled:Number = direction.magnitude();
			direction.normalize();
			
			var distanceDotDirection:Number = distance.dotProduct(direction); 
			var distanceDotDistance:Number = distance.dotProduct(distance);
			
			//TODO: rename.
			var d:Number = (distanceDotDirection * distanceDotDirection) + (radii * radii) - distanceDotDistance;
			var sqrt:Number = ( d > 0 ) ? Math.sqrt(d) : -1;
			
			//Time of intersection, if there is one.
			var intersectionTime:Number = distanceDotDirection - sqrt;
			
			//The two circles collide at time 0.
			if ( distance.magnitude() <= radii )
			{
				intersectionTime = 0;
			}
			
			//There is no intersection.
			if ( intersectionTime < 0 || intersectionTime > distanceTraveled || sqrt < 0 )
			{
				intersectionTime = -1;
			}
			
			return intersectionTime;
		}
		
		/**
		 * Returns the point of intersection between two bounding circles.
		 * @param	other		The bounding circle of the object that we are checking against for the point of intersection after a collision.
		 * @return				The point of intersection. If there is no point of intersection function return null.
		 */
		public function IntersectionPoint(other:BoundingCircle):Vector2D
		{
			//TODO: give better names, handle better.
			var d:Vector2D = center.subtract(other.center);
			var magB:Number = d.magnitude() - radius;
			
			if ( magB > other.radius )
			{
				return null;
			}
			
			var b:Vector2D = d.multiply(magB / d.magnitude());
			
			intersectionPoint = other.center.add(b);
			
			return intersectionPoint;
		}
		
		public function toggleDraw():void
		{
			drawImage = !drawImage;
		}
		
		private function draw():void
		{
			if ( drawImage )
			{
				//TODO: Draw the image!
			}
		}
	}
}