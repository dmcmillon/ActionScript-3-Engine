package engine.collision.box 
{
	import engine.math.Vector2D;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	/**
	 * Axis Aligned Bounding Box
	 * @author Daniel McMillon
	 */
	public class AABB 
	{
		private var min:Point;
		private var max:Point;
		private var center:Point;
		
		public function get top():Number
		{
			return min.y;
		}
		
		public function get bottom():Number
		{
			return max.y;
		}
		
		public function get left():Number
		{
			return min.x;
		}
		
		public function get right():Number
		{
			return max.x
		}
		
		public function AABB(min:Point, max:Point) 
		{
			this.min = min;
			this.max = max;
			
			center = new Point((min.x + max.x) / 2, (min.y + max.y) / 2);
		}
		
		public function intersectsAABB(other:AABB):Boolean
		{
			if ( top > other.bottom ) { return false; }
			if ( bottom < other.top ) { return false; }
			if ( left > other.right ) { return false; }
			if ( right < other.left ) { return false; }
			
			return true;
		}
	}
}