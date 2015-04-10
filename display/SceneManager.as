package engine.display 
{
	import engine.actor.Actor;
	import engine.gamescreens.MovieClipScreenManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
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
		
		public static function getInstance():SceneManager
		{
			if ( instance == null )
			{
				instance = new SceneManager(new MakeSingleton());
			}
			
			return instance;
		}
		
		private var sceneWidth:Number = 0.0;
		private var sceneHeight:Number = 0.0;
		
		private var sceneGraph:SceneGraph;
		
		//The game world is displayed on a bitmap instead of the stage to take advantage of blitting.
		private var sceneData:BitmapData;
		private var scene:Bitmap;
		
		//matrix allows a 1 pixel border around each image.
		private var matrix:Matrix = new Matrix(1, 0, 0, 1, 1, 1);
		
		private var stage:Stage;
		
		private var useBlitting:Boolean;
		
		//index of the world on the stage.
		private var worldIndex:int;
		
		public function get SceneWidth():Number
		{
			return sceneWidth;
		}
		
		public function get SceneHeight():Number
		{
			return sceneHeight;
		}
		
		public function SceneManager(dummy:MakeSingleton)
		{
			sceneGraph = new SceneGraph();
		}
		
		
		
		public function init(stage:Stage, useBlitting:Boolean = true):void
		{
			this.useBlitting = useBlitting;
			this.stage = stage;
			
			if ( useBlitting )
			{
				sceneWidth = stage.stageWidth;
				sceneHeight = stage.stageHeight;
				
				sceneData = new BitmapData(sceneWidth, sceneHeight, true, 0);
				scene = new Bitmap(sceneData);
				
				stage.addChild(scene);
			}
		}
		
		public function isBlitting():Boolean
		{
			return useBlitting;
		}
		
		/**
		 * Draws the different layers to the scene.
		 */
		public function render():void
		{
			checkBlitting();
			
			sceneData.fillRect(new Rectangle(0, 0, sceneData.width, sceneData.height), 0);
			
			sceneGraph.traverse(renderNode);
		}
		
		/**
		 * Draws an individual layer (background, game, foreground).
		 * @param	layer	The layer that is being drawn.
		 */
		private function renderNode(actor:IDisplayable, imageMatrix:Matrix):void
		{
			checkBlitting();
			
			//Each display object is first copied to a bitmap data object. The bitmap data object is then copied to the scene.
			var image:BitmapData = new BitmapData(actor.Image.width + 2, actor.Image.height + 2, true, 0);
			image.draw(actor.Image, matrix);
			sceneData.draw(image, imageMatrix, null, null, null, true);
		}
		
		public function addToForeground(actor:IDisplayable):void
		{
			checkBlitting();
			sceneGraph.addNode(actor, SceneGraph.FOREGROUND_LAYER);
		}
		
		public function addToBackground(actor:IDisplayable):void
		{	
			checkBlitting();
			sceneGraph.addNode(actor, SceneGraph.BACKGROUND_LAYER);
		}
		
		public function addToGameLayer(actor:IDisplayable):void
		{
			checkBlitting();
			sceneGraph.addNode(actor, SceneGraph.GAME_LAYER);
		}
		
		public function removeFromForeground(actor:IDisplayable):void
		{
			checkBlitting();
			sceneGraph.removeNode(actor, SceneGraph.FOREGROUND_LAYER);
		}
		
		public function removeFromBackground(actor:IDisplayable):void
		{
			checkBlitting();
			sceneGraph.removeNode(actor, SceneGraph.BACKGROUND_LAYER);
		}
		
		public function removeFromGameLayer(actor:IDisplayable):void
		{
			checkBlitting();
			sceneGraph.removeNode(actor, SceneGraph.GAME_LAYER);
		}
		
		private function checkBlitting():void
		{
			if ( !useBlitting )
			{
				throw new Error("Invalid method call. Not using blitting.");
			}
		}
		/////////////////////Functions to use if blitting is not enabled.//////////////////////////////		
		public function addWorld(actor:DisplayObject):void
		{
			stage.addChild(actor);
			worldIndex = stage.getChildIndex(actor);
		}
		
		public function removeWorld(actor:DisplayObject):void
		{
			stage.removeChild(actor);
		}
		
		public function addToWorld(actor:DisplayObject):void
		{
			(MovieClip)(stage.getChildAt(worldIndex)).addChild(actor);
		}
		
		public function removeFromWorld(actor:DisplayObject):void
		{
			(MovieClip)(stage.getChildAt(worldIndex)).removeChild(actor);
		}
	}
}

internal class MakeSingleton
{
	public function MakeSingleton() {}
}