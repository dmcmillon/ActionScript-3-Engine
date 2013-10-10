package engine.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class LevelEvents extends Event
	{
		
		public static const LEVEL_INCOMPLETE:String = "levelIncomplete";
		public static const LEVEL_COMPLETE:String = "levelComplete";
		
		public function LevelEvents(type:String, bubbles:Bool=false, cancelable:Bool=false) 
		{
			super(type, bubbles, cancelable);
		}
	}
}