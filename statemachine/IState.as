package engine.statemachine 
{
	/**
	 * Interface for all states that are used by a state machine.
	 * @author Daniel McMillon
	 */
	public interface IState 
	{
		function enter():void;
		function tick(deltaTime:Number):void;
		function exit():void;
	}
}