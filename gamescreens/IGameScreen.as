package engine.gamescreens 
{
	import engine.miscellaneous.ITickable;
	import flash.events.IEventDispatcher
	/**
	 * Interface for all game screens (ie game screen, menu screen, instruction screen, credits, etc.) that are placed on the screen stack.
	 * @author Daniel McMillon
	 */
	public interface IGameScreen extends ITickable, IEventDispatcher
	{
		//True if screen continues to update when it looses focus, false otherwise. 
		function get tickWhileSleep():Boolean;
		//Called everytime a screen gains focus.
		function setup():void;
		//Called when screen loses focus.
		function sleep():void;
		//Called when screen is destroyed.
		function teardown():void;
	}
}