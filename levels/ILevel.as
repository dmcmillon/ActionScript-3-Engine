package engine.levels 
{
	import engine.miscellaneous.ITickable;
	import flash.events.IEventDispatcher;
	/**
	 * Interface for all levels.
	 * @author Daniel McMillon
	 */
	public interface ILevel implements ITickable implements IEventDispatcher
	{
		function setup():Void;
		function teardown():Void;
	}
}