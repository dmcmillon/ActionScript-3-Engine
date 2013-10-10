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
	 * ...
	 * @author Daniel McMillon
	 */
	public class SceneManager
	{
		private static var instance:SceneManager;
		
		private var sceneWidth:Number = 0.0;
		private var sceneHeight:Number = 0.0;
		
		private var foregroundLayer:Vector.<ImageStruct>;
		private var backgroundLayer:Vector.<ImageStruct>;
		private var gameLayer:Vector.<ImageStruct>;
		
		private var sceneData:BitmapData;
		private var scene:Bitmap;
		
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
			foregroundLayer = new Vector.<ImageStruct>();
			backgroundLayer = new Vector.<ImageStruct>();
			gameLayer = new Vector.<ImageStruct>();
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
	
		public function renderScene():void
		{
			sceneData.fillRect(new Rectangle(0, 0, sceneData.width, sceneData.height), 0);
			
			sceneData.lock();
			renderLayer(backgroundLayer);
			renderLayer(gameLayer);
			renderLayer(foregroundLayer);
			sceneData.unlock();
		}
		
		private function renderLayer(layer:Vector.<ImageStruct>):void
		{
			for ( var index:int = 0; index < layer.length; index++ )
			{
				var image:BitmapData = new BitmapData(layer[index].image.width + 2, layer[index].image.height + 2, true, 0x00000000);
				image.draw(layer[index].image, matrix);
				sceneData.draw(image, layer[index].imageMatrix, null, null, null, true);
			}
		}
	
		public function addToForegroundLayer(image:DisplayObject, matrix:Matrix):void
		{
			var imageStruct:ImageStruct = new ImageStruct(image, matrix);
			
			foregroundLayer.push(imageStruct);
		}
		
		public function addToBackgroundLayer(image:DisplayObject, matrix:Matrix):void
		{
			var imageStruct:ImageStruct = new ImageStruct(image, matrix);
			
			backgroundLayer.push(imageStruct);
		}
		
		public function addToGameLayer(image:DisplayObject, matrix:Matrix):void
		{
			var imageStruct:ImageStruct = new ImageStruct(image, matrix);
			
			gameLayer.push(imageStruct);
		}
		
		public function removeFromForegroundLayer(image:DisplayObject):void
		{
			for ( var x:int = 0; x < foregroundLayer.length; x++ )
			{
				if ( foregroundLayer[x].image == image )
				{
					foregroundLayer.splice(x, 1);
					break;
				}
			}
		}
		
		public function removeFromBackgroundLayer(image:DisplayObject):void
		{
			for ( var x:int = 0; x < backgroundLayer.length; x++ )
			{
				if ( backgroundLayer[x].image == image )
				{
					backgroundLayer.splice(x, 1);
					break;
				}
			}
		}
		
		public function removeFromGameLayer(image:DisplayObject):void
		{
			for ( var x:int = 0; x < gameLayer.length; x++ )
			{
				if ( gameLayer[x].image == image )
				{
					gameLayer.splice(x, 1);
					break;
				}
			}
		}
	}
}

import flash.display.DisplayObject;
import flash.geom.Matrix;

internal class ImageStruct
{
	public var image:DisplayObject;
	public var imageMatrix:Matrix;
	
	public function ImageStruct(image:DisplayObject, matrix:Matrix)
	{
		this.image = image;
		imageMatrix = matrix;
	}
}

internal class MakeSingleton
{
	public function MakeSingleton() {}
}