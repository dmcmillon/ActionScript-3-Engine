package engine.math 
{
	/**
	 * A 2D vector class.
	 * @author Daniel McMillon
	 */
	public class Vector2D 
	{
		public static function dotProduct(vector1:Vector2D, vector2:Vector2D):Number
		{
			return vector1.x * vector2.x + vector1.y * vector2.y;
		}
		
		public static function distance(point1:Vector2D, point2:Vector2D):Number
		{
			return (Math.sqrt((point1.x - point2.x)*(point1.x - point2.x) + (point1.y - point2.y)*(point1.y - point2.y)));
		}
		
		//Faster than function distance because no square root. Use when comparing distances.
		public function distanceSquared(point1:Vector2D, point2:Vector2D):Number
		{
			return ((point1.x - point2.x)*(point1.x - point2.x) + (point1.y - point2.y)*(point1.y - point2.y));
		}
		
		public var x:Number;
		public var y:Number;
		
		public static function zero():Vector2D
		{
			return new Vector2D();
		}
		
		public function Vector2D(x:Number = 0.0, y:Number = 0.0) 
		{
			this.x = x;
			this.y = y;
		}

		public function add(vector:Vector2D):Vector2D
		{
			return new Vector2D(x + vector.x, y + vector.y);
		}
		
		public function addToVector(vector:Vector2D):void
		{
			x += vector.x;
			y += vector.y;
		}
		
		public function subtract(vector:Vector2D):Vector2D
		{
			return new Vector2D(x - vector.x, y - vector.y);
		}
		
		public function subtractFromVector(vector:Vector2D):void
		{
			x -= vector.x;
			y -= vector.y;
		}
		
		public function multiply(scalar:Number):Vector2D
		{
			return new Vector2D(scalar * x, scalar * y);
		}
		
		public function multiplyToVector(scalar:Number):void
		{
			x *= scalar;
			y *= scalar;
		}
		
		public function normalize():void
		{
			if ( x != 0 || y != 0 )
			{
				var tempX:Number = x;
				var tempY:Number = y;
				
				tempX /= magnitude();
				tempY /= magnitude();
				
				x = tempX;
				y = tempY;
			}
		}
		
		public function magnitude():Number
		{
			return Math.sqrt(x * x + y * y);
		}
		
		//Faster than function magnitude because no square root. Use when comparing magnitude with other vectors
		public function magnitudeSquared():Number
		{
			return (x * x + y * y)
		}
		
		public function clear():void
		{
			x = 0.0;
			y = 0.0;
		}
		
		//TODO: Test
		public function truncate(maxLength:Number):void
		{
			if ( magnitude() > maxLength )
			{
				normalize();
				multiply(maxLength);
			}
		}
	}
}