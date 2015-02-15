package engine.miscellaneous 
{
	import engine.math.Vector2D;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class FPS 
	{
		private var frames:int = 0;
		private var frameTimer:Number = 0.0;
		private var framesPerSecond:int = 0;
		
		private var textfield:TextField;
		
		public function FPS() 
		{
			var textfieldYPadding:int = 5;
			var textfieldXPadding:int = 5;
			
			textfield = new TextField();
			textfield.textColor = 0xFF0000;
			textfield.text = "FPS: 00"; 
			textfield.selectable = false;
			textfield.scaleX = 3;
			textfield.scaleY = 3;
			textfield.width = textfield.textWidth + textfieldXPadding;
			textfield.height = textfield.textHeight + textfieldYPadding;
			textfield.x = 0;
			textfield.y = 0;
		}
		
		public function calculate(deltaTime:Number):void
		{
			frames++;
			frameTimer += deltaTime;
			
			if ( frameTimer >= 1 )
			{
				framesPerSecond = frames;
				textfield.text = "FPS: " + framesPerSecond;
			
				frames = 0;
				frameTimer = 0.0;
			}
		}
		
		public function get FPSTextField():TextField
		{
			return textfield;
		}
	}
}