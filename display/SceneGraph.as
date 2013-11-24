package engine.display 
{
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class SceneGraph 
	{
		public static const BACKGROUND_LAYER:int = 0;
		public static const GAME_LAYER:int = 1;
		public static const FOREGROUND_LAYER:int = 2;
		
		//A vector of 3 layers on which images can be rendered. (Background, Game, Foreground)
		private var layers:Vector.< Vector.<SceneGraphNode> >;
		private var matrixStack:Vector.<Matrix>;
		
		public function SceneGraph() 
		{
			layers = new Vector.< Vector.<SceneGraphNode> >(3, true);
			layers[BACKGROUND_LAYER] = new Vector.<SceneGraphNode>();
			layers[GAME_LAYER] = new Vector.<SceneGraphNode>();
			layers[FOREGROUND_LAYER] = new Vector.<SceneGraphNode>();
			
			matrixStack = new Vector.<Matrix>();
			matrixStack.push(new Matrix());
		}
		
		public function addNode(actor:IDisplayable, layer:int):void
		{
			if ( layer < 0 || layer > 2 )
			{
				throw new Error("Invalid layer");
			}
			
			layers[layer].push(new SceneGraphNode(actor));
		}
		
		public function removeNode(actor:IDisplayable, layer:int):void
		{
			if ( layer < 0 || layer > 2 )
			{
				throw new Error("Invalid layer");
			}
			
			for ( var x:int = 0; x < layers[layer].length; x++ )
			{
				if ( layers[layer][x].getActor == actor )
				{
					layers[layer].splice(x, 1);
					break;
				}
			}
		}
		
		public function traverse(draw:Function):void
		{
			for ( var x:int = 0; x < layers.length; x++ )
			{
				for ( var y:int = 0; y < layers[x].length; y++ )
				{	
					drawNodes(layers[x][y], draw)
				}
			}
		}
		
		public function drawNodes(sceneGraphNode:SceneGraphNode, draw:Function):void
		{
			var matrix:Matrix = new Matrix();
			matrix.concat(sceneGraphNode.getActor.ImageMatrix);
			matrix.concat(matrixStack[matrixStack.length - 1]);
			
			if ( sceneGraphNode.isVisible )
			{
				draw(sceneGraphNode.getActor, matrix);
			}
			
			for ( var x:int = 0; x < sceneGraphNode.numChildren; x++ )
			{
				matrixStack.push(matrix);
				drawNodes(sceneGraphNode.getChild(x), draw);
				matrixStack.pop();
			}
		}
	}
}