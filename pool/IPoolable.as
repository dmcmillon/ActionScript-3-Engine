package engine.pool 
{
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public interface IPoolable 
	{
		function get isAlive():Boolean;
		function set isAlive(value:Boolean):void;
	}
	
}