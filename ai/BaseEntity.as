package engine.ai 
{
	import engine.math.Vector2D;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class BaseEntity 
	{
		private var id:int;
		
		private static var nextAvailableID:int = 0;
		
		private var position:Vector2D;
		private var rotation:Number;
		
		private var tag:Boolean = false;
		
		public function BaseEntity()
		{
			id = nextAvailableID;
			nextAvailableID++;
		}
		
		public function get ID():int
		{
			return id;
		}
	}
}