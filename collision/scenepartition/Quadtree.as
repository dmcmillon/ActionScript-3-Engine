package engine.collision.scenepartition 
{
	import flash.display.DisplayObject
	import flash.display.Graphics;
	/**
	 * This is my quadtree. It's not complete. I implemented putting the elements into the appropriate node, removing them from the node, and querying the node for 
	 * all elements inside the node.
	 * I did not get to update the quadtree to make sure that elements in the tree are in the proper node after movement occurs.
	 * @author Daniel McMillon
	 */
	
	public class Quadtree
	{
		public var subdivisionLevel:int;
		public var quadrant:String;
		
		private var maxElements:int = 0;
		private var maxDepth:int = 0;
		
		private var _x:Number = 0.0;
		private var _y:Number = 0.0;
		private var _width:Number = 0.0;
		private var _height:Number = 0.0;
		
		//An array of all the elements in the node. I use Tile instead of a point because the elements have width. I am thinking about making a 
		//helper struct that will hold the position, width, and height.
		private var elements:Vector.<DisplayObject>;
		
		//Child nodes of this node.
		private var topLeft:Quadtree;
		private var topRight:Quadtree;
		private var bottomLeft:Quadtree;
		private var bottomRight:Quadtree;
		
		public function Quadtree(x:Number, y:Number, width:Number, height:Number, maxElements:int, maxDepth:int) 
		{
			this._x = x;
			this._y = y;
			this._width = width;
			this._height = height;
			
			this.maxElements = maxElements;
			this.maxDepth = maxDepth;
			
			elements = new Vector.<DisplayObject>();
			
			topLeft = null;
			topRight = null;
			bottomLeft = null;
			bottomRight = null;
		}
		
		private function insert(element:DisplayObject):void
		{
			if ( topLeft.insertElement(element) ) return;
			if ( topRight.insertElement(element) ) return;
			if ( bottomLeft.insertElement(element) ) return;
			if ( bottomRight.insertElement(element) ) return;
				
			elements.push(element);
		}
		
		private function remove(element:DisplayObject):void
		{
			for ( var index:int = 0; index < elements.length; index++ )
			{
				if ( elements[index] == element )
				{
					elements.splice(index, 1);
					break;
				}
			}
		}
		
		private function isElementFullyContainedInNode(element:DisplayObject):Boolean
		{
			if ( _x <= element.x && _x + _width >= element.x + element.width && _y <= element.y && _y + _height >= element.y + element.height )
			{
				return true;
			}
			
			return false;
		}
		
		private function subdivide():void
		{
			var childWidth:Number = _width / 2;
			var childHeight:Number = _height / 2;
			
			topLeft = new Quadtree(_x, _y, childWidth, childHeight, maxElements, maxDepth - 1);
			topRight = new Quadtree(_x + childWidth, _y, childWidth, childHeight, maxElements, maxDepth - 1);
			bottomLeft = new Quadtree(_x, _y + childHeight, childWidth, childHeight, maxElements, maxDepth - 1);
			bottomRight = new Quadtree(_x + childWidth, _y + childHeight, childWidth, childHeight, maxElements, maxDepth - 1);
		}
		
		private function doesElementIntersectsChild(element:DisplayObject, childNode:Quadtree):Boolean
		{
			if ( element.x > childNode._x + childNode._width ) { return false; }
			if ( element.y > childNode._y + childNode._height ) { return false; }
			if ( element.x + element.width < childNode._x ) { return false; }
			if ( element.y + element.height < childNode._y ) { return false; }
			
			return true;
		}
		
		private function copyArray(array:Vector.<DisplayObject>):Vector.<DisplayObject>
		{
			var tempArray:Vector.<DisplayObject> = new Vector.<DisplayObject>(array.length);
			
			for (var index:int = 0; index < array.length; index++)
			{
				tempArray[index] = array[index];
			}
			
			return tempArray;
		}
		
		private function updateElement(element:DisplayObject):void
		{
			
		}
		
		public function insertElement(element:DisplayObject):Boolean
		{
			if ( !isElementFullyContainedInNode(element) )
			{
				return false;
			}
			
			if ( topLeft != null )
			{
				insert(element);
				return true;
			}
			
			elements.push(element);
			
			if ( elements.length > maxElements && maxDepth > 1 )
			{
				subdivide();
				
				var tempVector:Vector.<DisplayObject> = copyArray(elements);//new Vector.<DisplayObject>();
				
				elements.splice(0, elements.length);
					
				for ( var index:int = 0; index < tempVector.length; index++)
				{
					insert(tempVector[index]);
				}
			}
			
			return true;
		}
		
		public function removeElements(element:DisplayObject):void
		{
			if ( !isElementFullyContainedInNode(element) )
			{
				return;
			}
			
			//No child nodes
			if ( topLeft == null )
			{
				remove(element);
			}
			else
			{
				if ( topLeft.isElementFullyContainedInNode(element) )
				{
					topLeft.removeElements(element);
				}
				else if ( topRight.isElementFullyContainedInNode(element) )
				{
					topRight.removeElements(element);
				}
				else if ( bottomLeft.isElementFullyContainedInNode(element) )
				{
					bottomLeft.removeElements(element);
				}
				else if ( bottomRight.isElementFullyContainedInNode(element) )
				{
					bottomRight.removeElements(element);
				}
				else
				{
					remove(element);
				}
			}
		}
		
		//Queries 
		public function queryNode(element:DisplayObject):Vector.<DisplayObject>
		{
			var tempArray:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			
			tempArray = copyArray(elements);
			
			if ( topLeft != null )
			{
				//if the tile that is being queried is in more than one node, return an array of all elements of all nodes that the element is in.
				if ( doesElementIntersectsChild(element, topLeft) )
				{
					tempArray.concat(topLeft.queryNode(element));
				}
				if ( doesElementIntersectsChild(element, topRight) )
				{
					tempArray.concat(topRight.queryNode(element));
				}
				if ( doesElementIntersectsChild(element, bottomLeft) )
				{
					tempArray.concat(bottomLeft.queryNode(element));
				}
				if ( doesElementIntersectsChild(element, bottomRight) )
				{
					tempArray.concat(bottomRight.queryNode(element));
				}
			}
			
			return tempArray;
		}
		
		
	}
}