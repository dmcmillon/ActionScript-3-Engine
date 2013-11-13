package engine.display 
{
	import engine.actor.Actor;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Managers what is displayed in the scene.
	 * @author Daniel McMillon
	 */
	public class SceneManager
	{
		//Singleton class. There should only ever be one instance of this class.
		private static var instance:SceneManager;
		
		private var sceneWidth:Number = 0.0;
		private var sceneHeight:Number = 0.0;
		
		//vectors to hold objects in different layers. The game layer is drawn behind the foreground and the background is drawn behind the game layer.
		private var foregroundLayer:Vector.<IDisplayable>;
		private var backgroundLayer:Vector.<IDisplayable>;
		private var gameLayer:Vector.<IDisplayable>;
		
		//The game world is displayed on a bitmap instead of the stage to take advantage of blitting.
		private var sceneData:BitmapData;
		private var scene:Bitmap;
		
		//matrix allows a 1 pixel border around each image.
		private var matrix:Matrix = new Matrix(1, 0, 0, 1, 1, 1);
		
		public function get SceneWidth():Number
		{
			return sceneWidth;
		}
		
		public function get SceneHeight():Number
		{
			return sceneHeight;
		}
		
		public function get Scene():Bitmap
		{
			return scene;
		}
		
		public function SceneManager(dummy:MakeSingleton)
		{
			foregroundLayer = new Vector.<IDisplayable>();
			backgroundLayer = new Vector.<IDisplayable>();
			gameLayer = new Vector.<IDisplayable>();
		}
		
		public static function getInstance():SceneManager
		{
			if ( instance == null )
			{
				instance = new SceneManager(new MakeSingleton());
			}
			
			return instance;
		}
		
		public function init(sceneWidth:Number, sceneHeight:Number):void
		{
			this.sceneWidth = sceneWidth;
			this.sceneHeight = sceneHeight;
			
			sceneData = new BitmapData(sceneWidth, sceneHeight, true);
			scene = new Bitmap(sceneData);
		}
		
		/**
		 * Draws the different layers to the scene.
		 */
		public function renderScene():void
		{
			sceneData.fillRect(new Rectangle(0, 0, sceneData.width, sceneData.height), 0);
			
			sceneData.lock();
			renderLayer(backgroundLayer);
			renderLayer(gameLayer);
			renderLayer(foregroundLayer);
			sceneData.unlock();
		}
		
		/**
		 * Draws an individual layer (background, game, foreground).
		 * @param	layer	The layer that is being drawn.
		 */
		private function renderLayer(layer:Vector.<IDisplayable>):void
		{
			//Each display object is first copied to a bitmap data object. The bitmap data object is then copied to the scene.
			for ( var index:int = 0; index < layer.length; index++ )
			{
				var image:BitmapData = new BitmapData(layer[index].Image.width + 2, layer[index].Image.height + 2, true, 0x00000000);
				image.draw(layer[index].Image, matrix);
				sceneData.draw(image, layer[index].ImageMatrix, null, null, null, true);
			}
		}
	
		private function traverseSceneGraph():void
		{
			
		}
		
		public function addToForeground(actor:IDisplayable):void
		{
			foregroundLayer.push(actor);
		}
		
		public function addToBackground(actor:IDisplayable):void
		{	
			backgroundLayer.push(actor);
		}
		
		public function addToGameLayer(actor:IDisplayable):void
		{
			gameLayer.push(actor);
		}
		
		public function removeFromForeground(actor:IDisplayable):void
		{
			for ( var x:int = 0; x < foregroundLayer.length; x++ )
			{
				if ( foregroundLayer[x] == actor )
				{
					foregroundLayer.splice(x, 1);
					break;
				}
			}
		}
		
		public function removeFromBackground(actor:IDisplayable):void
		{
			for ( var x:int = 0; x < backgroundLayer.length; x++ )
			{
				if ( backgroundLayer[x] == actor )
				{
					backgroundLayer.splice(x, 1);
					break;
				}
			}
		}
		
		public function removeFromGameLayer(actor:IDisplayable):void
		{
			for ( var x:int = 0; x < gameLayer.length; x++ )
			{
				if ( gameLayer[x] == actor )
				{
					gameLayer.splice(x, 1);
					break;
				}
			}
		}
	}
}

internal class MakeSingleton
{
	public function MakeSingleton() {}
}