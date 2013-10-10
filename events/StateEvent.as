package engine.events 
{
	import engine.statemachine.IState;
	import flash.events.Event;
	/**
	 * Event used by states to tell the state machine to either add a new event, remove, change, or interrupt an event.
	 * @author Daniel McMillon
	 */
	public class StateEvent extends Event
	{
		public static const ADD:String = "add";
		public static const REMOVE:String = "remove";
		public static const CHANGE:String = "change";
		public static const INTERRUPT:String = "interrupt";
		
		public var newState:IState;
		public var currentState:IState;
		
		public function StateEvent(eventType:String, currentState:IState, newState:IState, bubble:Boolean = false, cancel:Boolean = false) 
		{
			super(eventType, bubble, cancel);
			
			this.newState = newState;
			this.currentState = currentState;
		}
		
		public function get State():IState
		{
			return state;
		}
	}
}