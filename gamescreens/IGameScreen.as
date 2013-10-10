package engine.gamescreens 
{
	import engine.miscellaneous.ITickable;
	import flash.events.IEventDispatcher;
	
	/**
	 * Interface for all game screens (ie game screen, menu screen, instruction screen, credits, etc.).
	 * @author Daniel McMillon
	 */
	public interface IGameScreen extends IEventDispatcher, ITickable
	{
		function setup():void;
		function sleep():void;
		function teardown():void;
	}
	
}