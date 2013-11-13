package engine.particles
{
	import engine.maths.Vector2D;
	import engine.pool.IPoolable;
	import engine.display.IDisplayable;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	/**
	 * Struct that holds the different attributes of a particles
	 */
	public class Particle implements IPoolable, IDisplayable
	{
		public var velocity:Vector2D;
		public var lifetime:int = 0;
		public var color:uint = 0xffffff;
		
		public var alive:Boolean = false;
		
		private var displayObject:Shape;
		private var position:Vector2D;
		
		private var matrix:Matrix;
		private var rotation:Number;
		
		public function Particle()
		{
			position = new Vector2D();
			velocity = new Vector2D();
			
			matrix = new Matrix();
		}
		
		public function get isAlive():Boolean
		{
			return alive;
		}
		
		public function set isAlive(value:Boolean):void
		{
			alive = value;
		}
		
		public function set Image(image:DisplayObject):void
		{
			if ( image )
			{
				displayObject = new Shape();
				displayObject.graphics.copyFrom(Shape(image).graphics);
			}
		}
		
		public function get Image():DisplayObject
		{
			if ( displayObject == null )
			{
				var circle:Shape = new Shape();
				circle.graphics.lineStyle(1, color);
				circle.graphics.drawCircle(0, 0, 1);
				displayObject = circle;
			}
			
			return displayObject;
		}
		
		public function set Rotation(value:Number):void
		{
			rotation = value;
			updateMatrix();
		}
		
		public function get ImageMatrix():Matrix
		{			
			return matrix;
		}
		
		public function get x():Number
		{
			return position.x;
		}
		
		public function set x(xPos:Number):void
		{
			position.x = xPos;
			updateMatrix();
			
			if ( displayObject != null )
			{
				displayObject.x = xPos;
			}
		}
	
		public function get y():Number
		{
			return position.y;
		}
		
		public function set y(yPos:Number):void
		{
			position.y = yPos;
			updateMatrix();
			
			if ( displayObject != null )
			{
				displayObject.y = yPos;
			}
		}
		
		private function updateMatrix():void
		{
			matrix.identity();
			matrix.rotate(rotation);
			matrix.translate(position.x, position.y);
		}
	}
}