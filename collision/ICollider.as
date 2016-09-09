package engine.collision 
{
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public interface ICollider 
	{
		function onCollision(collider:ICollider):void;
		function getBoundingVolume():IBoundingVolume;
	}
}