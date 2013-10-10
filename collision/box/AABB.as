package engine.collision.box 
{
	import engine.maths.Vector2D;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	/**
	 * Axis Aligned Bounding Box
	 * @author Daniel McMillon
	 */
	public class AABB 
	{
		private var min:Vector2D;
		private var max:Vector2D;
		
		public function AABB() 
		{
			min = Vector2D.zero();
			max = Vector2D.zero();
		}
		
		public function add(image:DisplayObject, imageTransform:Matrix):void
		{
			var topLeft:Point = imageTransform.transformPoint(new Point(image.x, image.y));
			var topRight:Point = imageTransform.transformPoint(new Point(image.width, image.y));
			var bottomLeft:Point = imageTransform.transformPoint(new Point(image.x, image.height));
			var bottomRight:Point = imageTransform.transformPoint(new Point(image.width, image.height));
			
			min.x = topLeft.x;
			min.y = topLeft.y;
			max.x = topLeft.x;
			max.y = topLeft.y;
			
			if ( min.x > topRight.x )
			
		}
		
		public function AABBCollisionCheck(other:AABB):Boolean
		{
			
		}
	}
}