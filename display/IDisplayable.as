package engine.display 
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public interface IDisplayable 
	{
		function get ImageMatrix():Matrix;
		function get Image():DisplayObject;
		function set Image(value:DisplayObject):void;
	}
	
}