package engine.math 
{
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class MathHelper 
	{
		public static function degreesToRadians(degrees:Number):Number
		{
			return degrees * Math.PI / 180;
		}
		
		public static function radiansToDegrees(radianNumber:Number):Number
		{
			return radianNumber * 180 / Math.PI;
		}
		
		public static function clampN(value:Number, min:Number, max:Number):Number
		{
			if ( value < min )
			{
				value = min;
			}
			else if ( value > max )
			{
				value = max;
			}
			
			return value
		}
		
		public static function clampI(value:int, min:int, max:int):int
		{
			if ( value < min )
			{
				value = min;
			}
			else if ( value > max )
			{
				value = max;
			}
			
			return value
		}
	}
}