package engine.spritemanagement 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class FontRenderer
	{
		private var tileRenderer:TileRenderer;
		
		public function FontRenderer(fontSheet:Bitmap, numChars:int, numCharsX:int, numCharsY:int) 
		{
			tileRenderer = new TileRenderer(fontSheet, numChars, numCharsX, numCharsY);	
		}
		
		public function convertText(text:String):BitmapData
		{
			return tileRenderer.getImage(index);
		}
		
		private function parseString(string:String):void
		{
			
		}
	}
}