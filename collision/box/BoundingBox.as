package engine.collision.box 
{
	import flash.geom.Rectangle;
	/**
	 * A bounding box for an actor.
	 * @author Daniel McMillon
	 */
	public class BoundingBox implements ICollisionBox
	{
		private var x:Number = 0.0;
		private var y:Number = 0.0;
		private var width:Number = 0.0;
		private var height:Number = 0.0;
		
		private var top:Number = 0.0;
		private var bottom:Number = 0.0;
		private var left:Number = 0.0;
		private var right:Number = 0.0;
		
		public function BoundingBox() 
		{
			x = 0.0;
			y = 0.0;
			width = 0.0;
			height = 0.0;
		}
		
		public function init(x:Number, y:Number, width:Number, height:Number):void
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			
			this.top = y;
			this.bottom = y + height;
			this.left = x;
			this.right = x + height;
		}
		
		public function set X(x:Number):void
		{
			this.x = x;
			left = x;
			right = x + width;
		}
		
		public function set Y(y:Number):void
		{
			this.y = y;
			top = y;
			bottom = y + height;
		}
		
		public function set Width(width:Number):void
		{
			this.width = width;
			right = x + width;
		}
		
		public function set Height(height:Number):void
		{
			this.height = height;
			bottom = y + height;
		}
		
		public function get X():Number
		{
			return x;
		}
		
		public function get Y():Number
		{
			return y;
		}
		
		public function get Width():Number
		{
			return width;
		}
		
		public function get Height():Number
		{
			return height;
		}
		
		public function get Left():Number
		{
			return left;
		}
		
		public function get Right():Number
		{
			return right;
		}
		
		public function get Top():Number
		{
			return top;
		}
		
		public function get Bottom():Number
		{
			return bottom;
		}
			
		public function intersects(rect:ICollisionBox):Boolean
		{
			
			var tempIntersects:Boolean = true;
			
			if ( this.right < rect.Left ) { tempIntersects = false; }
			if ( this.left > rect.Right ) { tempIntersects = false; }
			if ( this.top > rect.Bottom ) { tempIntersects = false; }
			if ( this.bottom < rect.Top ) { tempIntersects = false; }
			
			return tempIntersects;
		}
		
		//Returns a rectangle of the intersecting area between this bounding box and rect ICollisionBox parameter.
		//If the two ICollisionBoxs do not intersect an empty rectangle is returned.
		public function intersection(rect:ICollisionBox):Rectangle
		{
			var tempX:Number = 0.0;
			var tempY:Number = 0.0;
			var tempWidth:Number = 0.0;
			var tempHeight:Number = 0.0;
			
			if ( intersects(rect) )
			{
				if ( right > rect.Left && top < rect.Bottom )
				{
					tempX = rect.Left;
					tempY = top;
					tempWidth = right - rect.Left;
					tempHeight = rect.Bottom - top;
				}
				
				if ( right > rect.Left && bottom > rect.Top )
				{
					tempX = rect.Left;
					tempY = rect.Top;
					tempWidth = right - rect.Left;
					tempHeight = bottom - rect.Top;
				}
				
				if ( left < rect.Right && top < rect.Bottom )
				{
					tempX = left;
					tempY = top;
					tempWidth = rect.Right - left;
					tempHeight = rect.Bottom - top;
				}
				
				if ( left < rect.Right && bottom > rect.Top )
				{
					tempX = left;
					tempY = rect.Top;
					tempWidth = rect.Right - left;
					tempHeight = bottom - rect.Top;
				}
			}
			
			return new Rectangle(tempX, tempY, tempWidth, tempHeight);
		}
		
		public function updatePosition(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
			
			left = x;
			top = y;
			right = x + width;
			bottom = y + height;
		}
	}
}