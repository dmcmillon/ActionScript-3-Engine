package engine.display 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class StageManager extends Sprite
	{
		public static var instance:StageManager;
		
		public static function getInstance():StageManager
		{
			if ( instance == null )
			{
				instance = new StageManager(new Singleton());
			}
			
			return instance;
		}
		public function StageManager(dummy:Singleton) 
		{
			
		}
		
		
	}
}

internal class Singleton {}