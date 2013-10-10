package engine.events 
{
	import engine.gamescreens.IGameScreen;
	import flash.events.Event;
	
	/**
	 * Event to change the current screen to the screen specified in nextScreen.
	 * @author Daniel McMillon
	 */
	
	public class ChangeScreenEvent extends Event
	{
		public static const NEW_SCREEN:String = "newScreen";
		public static const OVERLAY_SCREEN:String = "overlayScreen";
		public static const REMOVE_OVERLAY_SCREEN:String = "removeOverlayScreen";
		
		public var nextScreen:IGameScreen;
		
		public function ChangeScreenEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
		}
	}
}