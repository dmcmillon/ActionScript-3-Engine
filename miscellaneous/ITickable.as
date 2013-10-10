package engine.miscellaneous 
{
	
	/**
	 * Interface for all tickable objects.
	 * @author Daniel McMillon
	 */
	public interface ITickable 
	{
		function tick(deltaTime:Number):void;
	}
}