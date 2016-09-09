package engine.weaponsystem 
{
	import engine.miscellaneous.ITickable
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class AbstractBomb extends Sprite implements ITickable
	{
		protected var explosionRadius:Number;
		protected var damage:int;
		
		protected var timeToExplode:Number;
		
		private var timer:Number = 0.0;
		
		public function AbstractBomb() 
		{
			
		}
		
		public function explode():void
		{
			parent.removeChild(this);
		}
		
		public function tick(deltaTime:Number):void
		{
			timer += deltaTime;
			
			if ( timer >= timeToExplode )
			{
				explode();
			}
		}
	}
}