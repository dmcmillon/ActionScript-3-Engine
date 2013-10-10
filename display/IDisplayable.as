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
		function get Image():DisplayObject;
		function get imageMatrix():Matrix;
	}
}