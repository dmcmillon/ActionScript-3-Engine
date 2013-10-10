package engine.scenePartition 
{
	/**
	 * This is my quadtree. It's not complete. I implemented putting the elements into the appropriate node, removing them from the node, and querying the node for 
	 * all elements inside the node.
	 * I did not get to update the quadtree to make sure that elements in the tree are in the proper node after movement occurs.
	 * @author Daniel McMillon
	 */
	
	public class Quadtree 
	{
		private var maxElements:int = 0;
		private var maxDepth:int = 0;
		
		private var x:Number = 0.0;
		private var y:Number = 0.0;
		private var width:Number = 0.0;
		private var height:Number = 0.0;
		
		//An array of all the elements in the node. I use Tile instead of a point because the elements have width. I am thinking about making a 
		//helper struct that will hold the position, width, and height.
		private var elements:Vector.<>;
		
		//Child nodes of this node.
		private var topLeft:Quadtree;
		private var topRight:Quadtree;
		private var bottomLeft:Quadtree;
		private var bottomRight:Quadtree;
		
		public function Quadtree(x:Number, y:Number, width:Number, height:Number, maxElements:int, maxDepth:int) 
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			
			this.maxElements = maxElements;
			this.maxDepth = maxDepth;
			
			elements = new Vector.<>();
			
			topLeft = null;
			topRight = null;
			bottomLeft = null;
			bottomRight = null;
		}
		
		public function insertElement(element:):void
		{
			//Checks if element is within this node.
			if ( !inBorder(element) )
			{
				return;
			}
			
			//Checks if current node has child nodes
			if ( topLeft != null )
			{
				topLeft.insertElement(element);
				topRight.insertElement(element);
				bottomLeft.insertElement(element);
				bottomRight.insertElement(element);
			}
			else
			{
				elements.push(element);
				
				if ( elements.length > maxElements )
				{
					subdivide();
					
					for ( index in 0...elements.length)
					{
						insertElement(elements[index]);
					}
					
					elements.splice(0, elements.length);
				}
			}
		}
		
		public function inBorder(element:):Boolean
		{
			return ( x <= element.x && y <= element.y && (x+width) >= element.x && (y+width) >= element.y );
		}
		
		public function subdivide():void
		{
			topLeft = new Quadtree(x, y, width / 2, height / 2, maxElements, maxDepth - 1);
			topRight = new Quadtree((x + width) / 2, y, width / 2, height / 2, maxElements, maxDepth - 1);
			bottomLeft = new Quadtree(x, (y + height) / 2, width / 2, height / 2, maxElements, maxDepth - 1);
			bottomRight = new Quadtree((x + width) / 2, (y + height) / 2, width / 2, height / 2, maxElements, maxDepth - 1);
		}
		
		public function removeElements(element:):void
		{
			if ( !inBorder(element) )
			{
				return;
			}
			//No child nodes
			if ( topLeft == null )
			{
				for ( index in 0...elements.length )
				{
					if ( elements[index] == element )
					{
						elements.remove(index);
					}
				}
			}
		}
		
		public function updateElement(element:):void
		{
			
		}
		
		//Queries 
		public function queryNode(element:):Vector.<>
		{
			var tempArray:Vector.<> = new Vector.<>();
			
			if ( !inBorder(element) )
			{
				return tempArray;
			}
			
			//no child nodes
			if ( topLeft == null )
			{
				tempArray = elements.copy();
			}
			else
			{
				//if the tile that is being queried is in more than one node, return an array of all elements of all nodes that the element is in.
				tempArray.concat(topLeft.queryNode(element).copy());
				tempArray.concat(topRight.queryNode(element).copy());
				tempArray.concat(bottomLeft.queryNode(element).copy());
				tempArray.concat(bottomRight.queryNode(element).copy());
			}
			
			return tempArray;
		}
	}
}

internal class QuadtreeNode
{
	public var x;
	public var y;
	public var width;
	public var height;
}