package engine.maths 
{
	/**
	 * A 2D vector class.
	 * @author Daniel McMillon
	 */
	public class Vector2D 
	{
		public var x:Number;
		public var y:Number;
		
		public static function zero():Vector2D
		{
			return new Vector2D(0.0, 0.0);
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
		
		public function subtract(vector:Vector2D):Vector2D
		{
			return new Vector2D(x - vector.x, y - vector.y);
		}
		
		public function multiply(scalar:Number):Vector2D
		{
			return new Vector2D(scalar * x, scalar * y);
		}
		
		public function dotProduct(vector:Vector2D):Number
		{
			return x * vector.x + y * vector.y;
		}
		
		public function normalize():void
		{
			var tempX:Number = x;
			var tempY:Number = y;
			
			if ( x != 0 && y != 0 )
			{
				tempX /= magnitude();
				tempY /= magnitude();
			}
			
			x = tempX;
			y = tempY;
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
			
		public function distance(point:Vector2D):Number
		{
			return (Math.sqrt((x - point.x)*(x - point.x) + (y - point.y)*(y - point.y)));
		}
		
		//Faster than function distance because no square root. Use when comparing distances.
		public function distanceSquared(point:Vector2D):Number
		{
			return ((x - point.x)*(x - point.x) + (y - point.y)*(y - point.y));
		}
	}
}