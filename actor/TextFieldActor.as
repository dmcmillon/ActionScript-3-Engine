package engine.actor 
{
	import engine.display.IDisplayable;
	import engine.maths.Vector2D;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.text.TextField;
	/**
	 * Actor for textfields. This is a struct that holds a textfield and its location in 2d space.
	 * @author Daniel McMillon
	 */
	public class TextFieldActor implements IDisplayable
	{
		//The location of the textfield.
		private var matrix:Matrix;
		private var image:TextField;
		
		public function TextFieldActor(textfield:TextField, position:Vector2D) 
		{
			image = textfield;
			matrix = new Matrix(2, 0, 0, 2, position.x, position.y);
		}
		
		public function set Position(position:Vector2D):void
		{
			matrix.translate(position.x, position.y);
		}
		
		public function get ImageMatrix():Matrix
		{
			return matrix;
		}
		
		public function get Image():DisplayObject
		{
			return image;
		}
		
		public function set Image(value:DisplayObject):void
		{
			image = TextField(value);
		}
	}
}