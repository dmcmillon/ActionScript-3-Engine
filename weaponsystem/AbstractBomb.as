package engine.weaponsystem 
{
	import engine.miscellaneous.ITickable
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class AbstractBomb extends IWeapon, ITickable
	{
		protected var explosionRadius:Number;
		protected var damage:int;
		
		public function AbstractBomb() 
		{
			
		}
		
		public function fire():void
		{
			
		}
		
		public function tick(deltaTime:Number):void
		{
			
		}
	}
}