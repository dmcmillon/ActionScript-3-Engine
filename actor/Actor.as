package engine.actor
{
	import engine.collision.box.AABB;
	import engine.collision.circle.BoundingCircle;
	import engine.events.ChildEvent;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	import flash.events.IEventDispatcher
	
	import engine.collision.box.ICollisionBox;
	import engine.pool.IPoolable;
	import engine.physics.movement.BaseMovementPhysics;
	import engine.math.Vector2D;
	import engine.math.MathHelper;
	import engine.display.IDisplayable;
	
	/**
	 * Container that holds data for visible objects on screen. This is the base class for all visible entities.
	 * Actor is controlled by a controller.
	 * @author Daniel McMillon
	 */

	public class Actor extends EventDispatcher implements IPoolable, IEventDispatcher, IDisplayable
	{		
		//Flags used for collision detection. AABB and BoundingCircle are bounding objects that allow for quick rejection of objects while doing collision detection.
		//They reject objects before more advanced and costly collision detection needs to be done.
		//Axis-Aligned Bounding Box not implemented yet
		//public static const AXIS_ALIGNED_BOUNDING_BOX:uint = 1;
		public static const BOUNDING_CIRCLE:uint = 2;
		
		public var isCollideable:Boolean = false;
		
		protected var isVisible:Boolean = true;
		
		protected var image:DisplayObject;
		protected var collisionBox:ICollisionBox;
		protected var physics:BaseMovementPhysics;
		protected var position:Vector2D;
		protected var rotation:Number;
		protected var scaleX:Number;
		protected var scaleY:Number;
		
		//A vector of child actors. Used to create a parent-child hierarchy of actors.
		protected var children:Vector.<Actor>;
		
		//The parent actor.
		protected var parent:Actor;
		
		//Axis Aligned Bounding Box
		//private var aabb:AABB = null;
		protected var boundingCircle:BoundingCircle = null;
		
		//matrix to transform the image on the screen.
		protected var matrix:Matrix;
		
		protected var alive:Boolean;
		
		//private var id:Number = 0;
		
		public function Actor()
		{
			matrix = new Matrix();
			
			children = new Vector.<Actor>();
			parent = null;			
		}
		
		/**
		 * Initializes the actor.
		 * @param	image			The displayable image that visually represents the actor.
		 * @param	position		The position of the actor in the world.
		 * @param	rotation		The actor's current rotation.
		 * @param	collisionBox	A collision box that surounds the actor.
		 * @param	physics			A physics component of the actor. If null object is not moveable.
		 * @param	scaleX			Scale in the x direction.
		 * @param	scaleY			Scale in the y direction.
		 * @param	bound			A flag that assigns an AABB or bounding circle to the actor for collision detection. 
		 * 							If bound is passed 1 the actor is assigned an AABB. If passed 2 the actor is assigned a bounding circle. 
		 * 							Bound can be passed both 1 and 2 for both an AABB and bounding circle to be assigned to the actor.
		 */
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
		
		public function addChild(child:Actor):void
		{
			if ( child.parent != null )
			{
				throw new Error("Actor must not have a parent!");
			}
			
			child.parent = this;
			children.push(child);
			
			var childAddedEvent:ChildEvent = new ChildEvent(ChildEvent.CHILD_ADDED);
			childAddedEvent.childActor = child;
			
			dispatchEvent(childAddedEvent);
		}
		
		public function removeChild(child:Actor):void
		{
			if ( child.parent != this )
			{
				throw new Error("Actor must be a child of this actor to remove it!");
			}
			
			child.parent = null;
			
			for ( var x:int = 0; x < children.length; x++ )
			{
				if ( child == children[x] )
				{
					children.splice(x, 1);
					break;
				}
			}
			
			var childRemovedEvent:ChildEvent = new ChildEvent(ChildEvent.CHILD_REMOVED);
			childRemovedEvent.childActor = child;
			
			dispatchEvent(childRemovedEvent);
		}
		
		public function toggleVisible():void
		{
			isVisible = !isVisible;
		}
		
		public function get IsVisible():Boolean
		{
			return isVisible;
		}
		
		public function set IsVisible(visibility:Boolean):void
		{
			isVisible = visibility;
		}
		
		public function get Children():Vector.<Actor>
		{
			return children.slice(0, children.length);
		}
		
		public function get numChildren():int
		{
			return children.length;
		}
		
		public function get Parent():Actor
		{
			return parent;
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
				//The registration point is at the center of the image which is why it's necessary set the current position of the collision box 
				//to the position of the image - half of the image size.
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
		
		/**
		 * This method updates the matrix that transforms the image. The matrix moves the registration point to the center of the image.
		 */
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