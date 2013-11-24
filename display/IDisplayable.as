package engine.display 
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	
	/**
	 * Interface for objects that can be desplayed on screen.
	 * @author Daniel McMillon
	 */
	public interface IDisplayable
	{
		function get ImageMatrix():Matrix;
		function get Image():DisplayObject;
		function set Image(value:DisplayObject):void;
		function set IsVisible(visibility:Boolean):void;
		function get IsVisible():Boolean;
	}
	
}