package engine.collision.scenepartition 
{
	import engine.ai.Vehicle;
	import engine.collision.box.AABB;
	import engine.math.Vector2D;
	import engine.miscellaneous.Iterator;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * Partitions the play area into cells.
	 * @author Daniel McMillon
	 */
	public class CellSpacePartitioning 
	{
		private var cells:Vector.<Cell>;
		private var neighbors:Vector.<Vehicle>;
		
		private var numCellsX:int;
		private var numCellsY:int;
		private var cellWidth:Number;
		private var cellHeight:Number;
		
		private var sprite:Sprite;
		
		public function CellSpacePartitioning(sceneWidth:Number, sceneHeight:Number, numCellsX:int, numCellsY:int) 
		{
			cellWidth = sceneWidth / numCellsX;
			cellHeight = sceneHeight / numCellsY;
			
			this.numCellsX = numCellsX;
			this.numCellsY = numCellsY;
			
			cells = new Vector.<Cell>();
			
			for ( var y:int = 0; y < numCellsY; y++ )
			{
				for ( var x:int = 0; x < numCellsX; x++ )
				{
					cells[y * numCellsX + x] = new Cell(new Point(x * cellWidth, y * cellHeight), 
														new Point(x * cellWidth + cellWidth, y * cellHeight + cellHeight));
				}
			}
		}
		
		public function begin():void
		{
			
		}
		
		
		public function render():Sprite
		{
			sprite = new Sprite();
			
			sprite.graphics.lineStyle(2);
			for ( var x:int = 0; x < numCellsX * numCellsY; x++ )
			{
				sprite.graphics.moveTo(cells[x].aabb.left, cells[x].aabb.top);
				
				sprite.graphics.lineTo(cells[x].aabb.right, cells[x].aabb.top);
				sprite.graphics.lineTo(cells[x].aabb.right, cells[x].aabb.bottom);
				sprite.graphics.lineTo(cells[x].aabb.left, cells[x].aabb.bottom);
				sprite.graphics.lineTo(cells[x].aabb.left, cells[x].aabb.top);
			}
			
			return sprite;
		}
		
		public function addEntity(vehicle:Vehicle):void
		{
			var cellIndex:int = convertPointToCell(vehicle.position);
			
			cells[cellIndex].members.push(vehicle);
		}
		
		public function updatePosition(vehicle:Vehicle, oldPos:Vector2D):void
		{
			var newCellIndex:int = convertPointToCell(vehicle.position);
			var oldCellIndex:int = convertPointToCell(oldPos);
			
			if ( oldCellIndex != newCellIndex )
			{
				var oldCell:Cell = cells[oldCellIndex];
				
				for ( var x:int = 0; x < oldCell.members.length; x++ )
				{
					if ( oldCell.members[x] == vehicle )
					{
						oldCell.members.splice(x, 1);
						break;
					}
				}
				
				cells[newCellIndex].members.push(vehicle);
			}
		}
		
		public function calculateNeighbors(position:Vector2D, queryRadius:Number)
		{
			neighbors.splice(0, neighbors.length);
			
			var queryAABB:AABB = new AABB(new Point(position.x - queryRadius, position.y - queryRadius), 
											new Point(position.x + queryRadius, position.y + queryRadius));
			
			for ( var cellIndex:int = 0; cellIndex < cells.length; cellIndex++ )
			{
				if ( queryAABB.intersectsAABB(cells[cellIndex].aabb) )
				{
					var cell:Cell = cells[cellIndex];
					
					for ( var cellMemberIndex:int = 0; cellMemberIndex < cell.members.length; cellMemberIndex++ )
					{
						if ( position.distanceSquared(cell.members[cellMemberIndex].position) < queryRadius * queryRadius )
						{
							neighbors.push(cell.members[cellMemberIndex]);
						}
					}//next cell member
				}
			}//next cell
		}
		
		private function convertPointToCell(point:Vector2D):int
		{
			var x:int = Math.floor(point.x / cellWidth);
			var y:int = Math.floor(point.y / cellHeight);
			
			return y * numCellsX + x;
		}
	}
}