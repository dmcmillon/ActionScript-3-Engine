package engine.weaponsystem 
{
	import engine.math.Vector2D;
	import engine.miscellaneous.ITickable;
	import engine.collision.ICollider
	
	/**
	 * ...
	 * @author Daniel
	 */
	public interface IBullet extends ITickable, ICollider
	{
		function get damage():int;
		function isAlive():Boolean;
		function init(position:Vector2D, rotation:Number/*velocity:Vector2D*/):void;
		function destroyBullet():void;
	}
	
}