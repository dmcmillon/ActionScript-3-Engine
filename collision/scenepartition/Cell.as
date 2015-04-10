package engine.collision.scenepartition 
{
	import engine.collision.box.AABB;
	import engine.ai.Vehicle;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class Cell
	{
		public var aabb:AABB;
		public var members:Vector.<Vehicle>;
		
		public function Cell(min:Point, max:Point) 
		{
			aabb = new AABB(min, max);
			members = new Vector.<Vehicle>();
		}
	}
}