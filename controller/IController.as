package engine.controller 
{
	/**
	 * Interface of controller objects. Controllers contain logic to control actors.
	 * @author Daniel McMillon
	 */
	public interface IController 
	{
		function setup():void;
		function dispose():void;
	}
}