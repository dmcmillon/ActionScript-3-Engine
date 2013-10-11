package engine.gamescreens 
{
	import engine.miscellaneous.ITickable;
	import flash.events.IEventDispatcher;
	
	/**
	 * Interface for all game screens (ie game screen, menu screen, instruction screen, credits, etc.) that are placed on the screen stack.
	 * @author Daniel McMillon
	 */
	public interface IGameScreen extends IEventDispatcher, ITickable
	{
		//function called everytime a screen gains focus.
		function setup():void;
		//function called when screen loses focus.
		function sleep():void;
		//function called when screen is destroyed.
		function teardown():void;
	}
	
}