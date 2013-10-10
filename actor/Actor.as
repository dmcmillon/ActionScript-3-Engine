package engine.actor
{
	import engine.collision.box.AABB;
	import engine.collision.circle.BoundingCircle;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;

	import engine.collision.box.ICollisionBox;
	import engine.pool.IPoolable;
	import engine.physics.movement.BaseMovementPhysics;
	import engine.maths.Vector2D;
	import engine.maths.MathHelper;
	//import engine.miscellaneous.IDisplayable;
	
	/**
	 * Container that holds data for visible objects on screen.
	 * @author Daniel McMillon
	 */

	public class Actor implements IPoolable//, IDisplayable
	{
		//Flags used for collision detection. AABB and BoundingCircle are bounding objects that allow for quick rejection of objects while doing collision detection.
		//They reject objects before more advanced and costly collision detection needs to be done.
		public static const BOUNDING_CIRCLE:uint = 2;
		
		//Axis-Aligned Bounding Box not implemented yet
		//public static const AXIS_ALIGNED_BOUNDING_BOX:uint = 1;
		public var isCollideable:Boolean = false;
		
		protected var image:DisplayObject;
		protected var collisionBox:ICollisionBox;
		protected var physics:BaseMovementPhysics;
		protected var position:Vector2D;
		protected var rotation:Number;
		protected var scaleX:Number;
		protected var scaleY:Number;
		
		//Axis Aligned Bounding Box
		//private var aabb:AABB = null;
		protected var boundingCircle:BoundingCircle = null;
		
		//matrix to transform the registration point from the top left corner to the center of the image.
		protected var matrix:Matrix;
		
		protected var alive:Boolean;
		
		public function Actor()
		{
			matrix = new Matrix();
		}
		
		public function init(image:DisplayObject, position:Vector2D, rotation:Number = 0, collisionBox:ICollisionBox = null, physics:BaseMovementPhysics = null, scaleX:Number = 1, scaleY:Number = 1, bound:uint = 0):void
		{
			this.image = image;
			this.position = position;
			this.rotation = rotation;
			this.scaleX = scaleX;
			this.scaleY = scaleY;
			
			this.physics = physics;
			
			
			if ( (bound & Actor.BOUNDING_CIRCLE) == Actor.BOUNDING_CIRCLE )
			{
				var radius:Vector2D = new Vector2D((0, (image.height * scaleY) >> 1));
				boundingCircle = new BoundingCircle(position, radius.magnitude());
			}
			/*
			if ( (bound & Actor.AXIS_ALIGNED_BOUNDING_BOX) == Actor.AXIS_ALIGNED_BOUNDING_BOX )
			{
				
			}
			*/
			updateMatrix();
			CollisionBox = collisionBox;
			
			alive = true;
		}
		
		public function get Image():DisplayObject
		{
			return image;
		}
		
		public function set Image(value:DisplayObject):void
		{
			image = value;

			updateMatrix();
		}
		
		public function get CollisionBox():ICollisionBox
		{
			return collisionBox;
		}
		
		public function set CollisionBox(value:ICollisionBox):void
		{
			collisionBox = value;
			
			if ( collisionBox != null )
			{	
				collisionBox.init(position.x - ((image.width * scaleX) >> 1), position.y - ((image.height * scaleY) >> 1), image.width * scaleX, image.height * scaleY);
			}
		}
		
		public function get CollisionCircle():BoundingCircle
		{
			 return boundingCircle;
		}
		
		public function get Physics():BaseMovementPhysics
		{
			return physics;
		}
		
		public function set Physics(value:BaseMovementPhysics):void
		{
			physics = value;
		}
		
		public function get ScaleX():Number
		{
			return scaleX;
		}
		
		public function set ScaleX(value:Number):void
		{
			scaleX = value;
			
			if ( collisionBox != null )
			{
				collisionBox.Width = image.width * scaleX;
			}
			
			updateBoundingCircleRadius();
			
			updateMatrix();
		}
		
		public function get ScaleY():Number
		{
			return scaleY;
		}
		
		public function set ScaleY(value:Number):void
		{
			scaleY = value;
			
			if ( collisionBox != null )
			{
				collisionBox.Height = image.height * scaleY;
			}
			
			updateBoundingCircleRadius();
			
			updateMatrix();
		}
		
		public function get Rotation():Number
		{
			return rotation;
		}
		
		public function set Rotation(value:Number):void
		{
			rotation = value;
		
			updateMatrix();
		}
		
		public function get Position():Vector2D
		{
			return position;
		}
		
		public function set Position(value:Vector2D):void
		{
			position = value;
			
			if ( collisionBox != null )
			{
				collisionBox.updatePosition(position.x - ((image.width * scaleX) >> 1), position.y - ((image.height * scaleY) >> 1));
			}
			
			if ( boundingCircle != null )
			{
				boundingCircle.updatePosition(position);
			}
			
			updateMatrix();
		}
		
		public function get isAlive():Boolean
		{
			return alive;
		}
		
		public function set isAlive(value:Boolean):void
		{
			alive = value;
		}
		
		public function updateBoundingCircleRadius():void
		{
			if ( boundingCircle != null )
			{
				var radius:Vector2D = (image.height > image.width) ? new Vector2D(0, (image.height * scaleY) >> 1) : new Vector2D((image.width * scaleX) >> 1, 0)
				boundingCircle.updateRadius(radius.magnitude());
			}
		}
		
		public function get ImageMatrix():Matrix
		{
			return matrix;
		}
		
		public function updateMatrix():void
		{
			matrix.identity();
			matrix.translate( -(image.width >> 1), -(image.height >> 1) );
			matrix.rotate(MathHelper.degreesToRadians(rotation));
			matrix.scale(scaleX, scaleY);
			matrix.translate(position.x, position.y);
		}
	}
}