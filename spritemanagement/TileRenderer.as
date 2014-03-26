package engine.spritemanagement 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class TileRenderer 
	{
		private var spriteSheet:Bitmap;
		private var numSpritesX:int;
		private var numSpritesY:int;
		
		private var spriteWidth:int;
		private var spriteHeight:int;
		
		private var tiles:Vector.<Tile>;
		private var bd:BitmapData;
		public function TileRenderer(spriteSheet:Bitmap, numSprites:int, numSpritesX:int, numSpritesY:int) 
		{
			spriteSheet = spriteSheet;
			this.numSpritesX = numSpritesX;
			this.numSpritesY = numSpritesY;
			
			spriteWidth = spriteSheet.width / numSpritesX;
			spriteHeight = spriteSheet.height / numSpritesY;
			
			tiles = new Vector.<Tile>(numSprites, true);
			
			divideSpriteSheet();
		}
		
		private function divideSpriteSheet():void
		{
			var index:int = 0;
			
			for ( var y:int = 0; y < numSpritesX; y++ )
			{
				for ( var x:int = 0; x < numSpritesY; x++ )
				{
					var tile:Tile = new Tile(spriteWidth * x, spriteHeight * y, spriteWidth, spriteHeight);
					
					tiles[index] = tile;
					
					//TODO: Check if the last sprite in spritesheet has been added to tiles.					
					index++;
					
					if ( index >= tiles.length )
					{
						break;
					}
				}
			}
		}
		
		public function getImage(index:int):BitmapData
		{
			var image:BitmapData = new BitmapData(spriteWidth, spriteHeight);
			image.copyPixels(spriteSheet, tiles[index].rectangle, new Point());
			
			return image;
		}
		
		public function dispose():void
		{
			spriteSheet.bitmapData.dispose();
			tiles = null;
		}
	}
}