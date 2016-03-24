package engine.actor
{
	import engine.collision.box.AABB;
	import engine.collision.circle.BoundingCircle;
	import engine.events.ChildEvent;
	import engine.physics.movement.IMovementPhysics;
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
	import engine.math.Vector2D;
	import engine.math.MathHelper;
	import engine.display.IDisplayable;
	
	/**
	 * Container that holds data for visible objects on screen. This is the base class for all visible entities.
	 * Actor is controlled by a controller.
	 * @author Daniel McMillon
	 */

	public class Actor extends Sprite //implements IPoolable
	{		/*
		//public static const AXIS_ALIGNED_BOUNDING_BOX:uint = 1;
		
		protected var _isCollideable:Boolean = false;
		
		protected var _isVisible:Boolean = true;
		
		protected var _collisionBox:ICollisionBox;
		
		protected var _physics:IMovementPhysics;
		
		//Axis Aligned Bounding Box
		//private var aabb:AABB = null;
		
		protected var _isAlive:Boolean;
		*/
		public function Actor()
		{
			
		}
		
		/**
		 * Initializes the actor.
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
		
		 /*
		public function init():void
		{
			
			_position = position;
			
			_physics = physics;
			
			_collisionBox = collisionBox;
			
			_isAlive = true;
		}
		
		public function toggleVisibility():void
		{
			_isVisible = !_isVisible;
		}
		
		public function get isVisible():Boolean
		{
			return _isVisible;
		}
		
		public function set isVisible(value:Boolean):void
		{
			_isVisible = value;
		}
		
		public function get isCollideable():Boolean
		{
			return _isCollideable;
		}
		
		public function get collisionBox():ICollisionBox
		{
			return _collisionBox;
		}
		
		public function set collisionBox(value:ICollisionBox):void
		{
			_collisionBox = value;
			
			if ( _collisionBox != null )
			{	
				//The registration point is at the center of the image which is why it's necessary set the current position of the collision box 
				//to the position of the image - half of the image size.
				_collisionBox.init(_position.x - ((width * scaleX) >> 1), _position.y - ((height * scaleY) >> 1), width * scaleX, height * scaleY);
			}
		}
		
		public function set physics(value:IMovementPhysics):void
		{
			_physics = value;
		}
		
		
		
		public function get position():Vector2D
		{
			var pos:Vector2D;
			
			if ( _physics != null )
			{
				//pos = 
			}
			return _physics.position;
		}
		
		public function set position(value:Vector2D):void
		{
			_physics.position = value;
			x = value.x;
			y = value.y;
			
			if ( _collisionBox != null )
			{
				_collisionBox.updatePosition(_position.x - ((width * scaleX) >> 1), _position.y - ((height * scaleY) >> 1));
			}
		}
		
		public function get velocity():Vector2D
		{
			return _velocity;
		}
		
		public function set velocity(value:Vector2D):void
		{
			_velocity = value;
		}
		
		private var _maxSpeed:Number = Number.MAX_VALUE;
		private var _speed:Number;
		
		private var _rotation:Number;
		private var _rotationSpeed:Number;
		
		private var _thrust:Number;
		public function get speed():Number
		{
			return _speed;
		}
		
		public function set speed(value:Number):void
		{
			_speed = value;
		}
		
		
		
		
		
		
		
		public function get isAlive():Boolean
		{
			return _isAlive;
		}
		
		public function set isAlive(value:Boolean):void
		{
			_isAlive = value;
		}*/
	}
}