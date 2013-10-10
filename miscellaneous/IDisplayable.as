package engine.miscellaneous 
{
	import engine.maths.Vector2D;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public interface IDisplayable 
	{
		function get Position():Vector2D;
		function get Image():DisplayObject;
		function get imageMatrix():Matrix;
	}
}