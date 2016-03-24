package engine.physics.movement 
{
	import engine.math.Vector2D;
	
	/**
	 * ...
	 * @author Daniel
	 */
	public interface IMovementPhysics 
	{
		function get position():Vector2D;
		function set position(pos:Vector2D):void;
		
		function get velocity():Vector2D;
		
		function get maxSpeed():Number;
		function set maxSpeed(speed:Number):void;
		
		function get speed():Number;
		function set speed(speed:Number):void;
		
		function get rotation():Number;
		function set rotation(rot:Number):void;
		
		function get rotationSpeed():Number;
		function set rotationSpeed(rotSpeed:Number):void;
		
		function get acceleration():Number;
		function set acceleration(acc:Number):void;
		
		function init(position:Vector2D, speed:Number, maxSpeed:Number, rotation:Number, rotationSpeed:Number, acceleration:Number):void
		function moveForward():void;
		//function strafe():void;
		function rotate(amount:Number):void;
		//function addForce(force:Vector2D):void;
	}
}