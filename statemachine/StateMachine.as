package engine.statemachine 
{
	//import engine.actor.Actor;
	//BaseEntity
	import engine.miscellaneous.ITickable;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class StateMachine extends EventDispatcher implements ITickable
	{
		private var globalStates:Vector.<IState>;
		private var currentStates:Vector.<IState>;
		//private var previousStates:Vector.<IState>;
		
		private var owner:BaseEntity;
		
		public function StateMachine(owner:BaseEntity) 
		{
			this.owner = owner;
			
			currentStates = new Vector.<IState>();
			globalStates = new Vector.<IState>();
			//previousStates = new Vector.<IState>();
		}
		
		private function addState(event:StateEvent):void
		{			
			var newState:IState = (IState)(event.newState);
		
			newState.enter();
			addCurrentState(newState);
		}
		
		private function removeState(event:StateEvent):void
		{
			var deleteState:IState = (IState)(event.currentState);
		
			deleteState.exit();
			removeCurrentState(deleteState);
		}
		
		public function changeState(event:StateEvent):void
		{			
			var currentState:IState = (IState)(event.currentState);
			var nextState:IState = (IState)(event.newState);
			
			currentState.exit();
			removeCurrentState(currentState);
			nextState.enter();
			addCurrentState(nextState);
		}
		
		private function interruptState(event:StateEvent):void
		{
			for ( var i:int = 0; i < currentStates.length; i++ )
			{
				previousStates[i] = currentStates[i];
			}
		
			currentStates.splice(0, currentStates.length);
			var newState:IState = (IState)(event.newState);
			newState.enter();
			
			addCurrentState(newState);
		}
		
		public function addGlobalState(state:IState):void
		{
			globalStates.push(state);
			
			state.addEventListener(StateEvent.ADD, addState);
			state.addEventListener(StateEvent.REMOVE, removeState);
			state.addEventListener(StateEvent.CHANGE, changeState);
			state.addEventListener(StateEvent.INTERRUPT, interruptState);
		}
		
		public function removeGlobalState(state:IState):void
		{
			for ( var i:int = 0; i < globalStates.length; i++ )
			{
				if ( globalStates[i] == state )
				{
					globalStates.splice(i, 1);
					break;
				}
			}
			
			state.removeEventListener(StateEvent.ADD, addState);
			state.removeEventListener(StateEvent.REMOVE, removeState);
			state.removeEventListener(StateEvent.CHANGE, changeState);
			state.removeEventListener(StateEvent.INTERRUPT, interruptState);
		}
		
		public function addCurrentState(state:IState):void
		{
			currentStates.push(state);
			
			state.addEventListener(StateEvent.ADD, addState);
			state.addEventListener(StateEvent.REMOVE, removeState);
			state.addEventListener(StateEvent.CHANGE, changeState);
			state.addEventListener(StateEvent.INTERRUPT, interruptState);
		}
		
		public function removeCurrentState(state:IState):void
		{
			for ( var i:int = 0; i < currentStates.length; i++ )
			{
				if ( currentStates[i] == state )
				{
					currentStates.splice(i, 1);
					break;
				}
			}
			
			state.removeEventListener(StateEvent.ADD, addState);
			state.removeEventListener(StateEvent.REMOVE, removeState);
			state.removeEventListener(StateEvent.CHANGE, changeState);
			state.removeEventListener(StateEvent.INTERRUPT, interruptState);
		}
		
		public function tick(deltaTime:Number):void
		{
			for each ( var globalState:IState in globalStates )
			{ 
				globalState.tick(deltaTime); 
			}
			
			for each ( var currentstate:IState in currentStates ) 
			{ 
				currentState.tick(deltaTime); 
			}
		}
	}
}