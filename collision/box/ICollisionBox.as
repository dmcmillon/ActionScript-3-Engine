package engine.collision.box 
{
	import flash.geom.Rectangle;
	
	/**
	 * Interface for all collision boxes.
	 * @author Daniel McMillon
	 */
	public interface ICollisionBox 
	{
		function init(x:Number, y:Number, width:Number, height:Number):void;
		function intersects(rect:ICollisionBox):Boolean;
		function intersection(rect:ICollisionBox):Rectangle;
		function updatePosition(x:Number, y:Number):void;
		
		function set X(x:Number):void;
		function set Y(y:Number):void;
		function set Width(width:Number):void;
		function set Height(height:Number):void;
		
		function get X():Number;
		function get Y():Number;
		function get Width():Number;
		function get Height():Number;
		function get Left():Number;
		function get Right():Number;
		function get Top():Number;
		function get Bottom():Number;
	}
}