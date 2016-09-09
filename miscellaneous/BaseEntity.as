package engine.miscellaneous 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class BaseEntity extends Sprite
	{
		private var entityName:String;		
		
		public function BaseEntity(entityName:String = "")
		{
			this.entityName = entityName;
		}
		
		public function get EntityName():String
		{
			return entityName;
		}
	}
}