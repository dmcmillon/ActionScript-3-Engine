package engine.spritemanagement 
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class Tile 
	{
		private var rect:Rectangle;
		
		public function Tile(x:int, y:int, width:int, height:int) 
		{
			rect = new Rectangle(x, y, width, height);
		}
		
		public function get rectangle():Rectangle
		{
			return rect;
		}
	}
}