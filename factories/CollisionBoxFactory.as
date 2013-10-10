package engine.factories 
{
	import engine.collision.box.BoundingBox;
	import engine.collision.box.ICollisionBox;
	/**
	 * Factory to create collision boxes
	 * @author Daniel McMillon
	 */
	public class CollisionBoxFactory
	{
		public function createBoundingBox():ICollisionBox
		{			
			return new BoundingBox();
		}
	}
}