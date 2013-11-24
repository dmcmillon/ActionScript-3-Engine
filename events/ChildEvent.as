package engine.events 
{
	import engine.display.IDisplayable;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class ChildEvent extends Event 
	{
		//Events that specify when a child is added to or removed from an actor.
		public static const CHILD_ADDED:String = "childAdded";
		public static const CHILD_REMOVED:String = "childRemoved";
		
		//The child actor that was added to or removed from the parent actor.
		public var childActor:IDisplayable;
		
		public function ChildEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
		}
	}
}