package engine.maths 
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
	}
}