package engine.collision.box 
{
	import engine.collision.IBoundingVolume;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * Axis Aligned Bounding Box
	 * @author Daniel McMillon
	 */
	public class AABB implements IBoundingVolume
	{
		private var _min:Point;
		private var _max:Point;
		
		private var _owner:DisplayObject;
		
		public function AABB(owner:DisplayObject,  min:Point = null, max:Point = null) 
		{
			_owner = owner;
			
			_min = min;
			_max = max;
		}
		
		public function intersects(volume:IBoundingVolume):Boolean
		{
			var isIntersection:Boolean = false;
			
			if ( volume is AABB ) 
			{
				isIntersection = intersectsAABB(volume as AABB);
			}
			
			//if ( volume is BoundingCircle )
			//{
				//return intersectsCircle(volume);
			//}
			
			return isIntersection;
		}
		
		public function update(min:Point, max:Point)
		{
			_min = min;
			_max = max;
		}
		
		private function intersectsAABB(other:AABB):Boolean
		{
			var minPoint:Point = (_min == null) ? new Point(_owner.x, _owner.y) : new Point(_owner.x + _min.x, _owner.y + _min.y);
			var maxPoint:Point = (_max == null) ? new Point(_owner.x + _owner.width, _owner.y + _owner.height) : new Point(_owner.x + _max.x, _owner.y + _max.y);
			
			var otherMinPoint:Point = (other._min == null) ? new Point(other._owner.x, other._owner.y) : new Point(other._owner.x + other._min.x, other._owner.y + other._min.y);
			var otherMaxPoint:Point = (other._max == null) ? new Point(other._owner.x + other._owner.width, other._owner.y + other._owner.height) : 
												new Point(other._owner.x + other._max.x, other._owner.y + other._max.y);
												
			if ( minPoint.y > otherMaxPoint.y ) { return false; }
			if ( maxPoint.y < otherMinPoint.y ) { return false; }
			if ( minPoint.x > otherMaxPoint.x ) { return false; }
			if ( maxPoint.x < otherMinPoint.x ) { return false; }
			
			return true;
		}
		
		public function rect():Rectangle
		{
			var minPoint:Point = (_min == null) ? new Point(_owner.x, _owner.y) : new Point(_owner.x + _min.x, _owner.y + _min.y);
			var maxPoint:Point = (_max == null) ? new Point(_owner.x + _owner.width, _owner.y + _owner.height) : new Point(_owner.x + _max.x, _owner.y + _max.y);
			
			return new Rectangle(minPoint.x, minPoint.y, maxPoint.x - minPoint.x, maxPoint.y - minPoint.y);
		}
	}
}