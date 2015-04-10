package engine.miscellaneous 
{
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class BaseEntity 
	{
		private var id:int;
		
		private static var nextAvailableID:int = 0;
		
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