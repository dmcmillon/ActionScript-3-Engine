package engine.collision 
{
	import engine.collision.scenepartition.Quadtree;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class CollisionManager 
	{
		private static var instance:CollisionManager;
		
		public static function getInstance():CollisionManager
		{
			if ( instance == null )
			{
				instance = new CollisionManager(new Singleton());
			}
			return instance;
		}
		
		private var quadtree:Quadtree;
		private var colliders:Vector.<ICollider>;
		private var world:Sprite;
		
		public function CollisionManager(singleton:Singleton) 
		{
			colliders = new Vector.<ICollider>();
		}
		
		public function setWorld(world:Sprite):void
		{
			this.world = world;
			quadtree = new Quadtree(0, 0, world.width, world.height, 10, 6);
		}
		
		public function addCollider(collider:ICollider):void
		{
			for ( var x:int = 0; x < colliders.length; x++ )
			{
				if ( colliders[x] == collider )
				{
					return;
				}
			}
			
			colliders.push(collider);
			quadtree.insertElement(collider as DisplayObject);
		}
		
		public function removeCollider(collider:ICollider):void
		{
			for ( var x:int = 0; x < colliders.length; x++ )
			{
				if ( colliders[x] == collider )
				{
					quadtree.removeElements(collider as DisplayObject);
					colliders.splice(x, 1);
					break;
				}
			}
		}
		
		public function checkForCollision():void
		{
			for ( var x:int = 0; x < colliders.length; x++ )
			{
				var colliderBoundingVolume:IBoundingVolume = colliders[x].getBoundingVolume();
				
				//var neighboringColliders:Vector.<DisplayObject> = quadtree.queryNode(colliders[x] as DisplayObject);
				
				//for (var y:int = 0; y < neighboringColliders.length; y++)
				for (var y:int = 0; y < colliders.length; y++)
				{
					//var neighboringCollider:ICollider = neighboringColliders[y] as ICollider;
					
					//if ( colliders[x] == neighboringCollider )
					if ( colliders[x] == colliders[y] )
					{
						continue;
					}
					
					//if ( colliderBoundingVolume.intersects(neighboringCollider.getBoundingVolume()) )
					if ( colliderBoundingVolume.intersects(colliders[y].getBoundingVolume()) )
					{
						/*
						var bitmapRectange1:Rectangle = DisplayObject(colliders[x]).getBounds(world);
						var bitmapData1:BitmapData = new BitmapData(bitmapRectange1.width, bitmapRectange1.height);
						bitmapData1.draw(colliders[x] as DisplayObject);
						
						var bitmapRectange2:Rectangle = DisplayObject(colliders[y]).getBounds(world);
						var bitmapData2:BitmapData = new BitmapData(bitmapRectange2.width, bitmapRectange2.height);
						bitmapData2.draw(colliders[y] as DisplayObject);
						
						if ( bitmapData1.hitTest(new Point(DisplayObject(colliders[x]).x, DisplayObject(colliders[x]).y), 255, bitmapData2, 
							 new Point(DisplayObject(colliders[y]).x, DisplayObject(colliders[y]).y), 255) )
						{
							
						}
						*/
						//colliders[x].onCollision(neighboringCollider);
						colliders[x].onCollision(colliders[y]);
					}
				}
			}
		}
	}	
}

internal class Singleton
{
	public function Singleton() { }
}