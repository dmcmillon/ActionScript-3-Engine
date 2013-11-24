package engine.display 
{
	import engine.actor.Actor;
	import engine.events.ChildEvent;
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class SceneGraphNode
	{
		private var actor:IDisplayable;
		private var children:Vector.<SceneGraphNode>;
		
		public function getChild(index:int):SceneGraphNode
		{
			return children[index];
		}
		
		public function get numChildren():int
		{
			return children.length;
		}
		
		public function get getActor():IDisplayable
		{
			return actor;
		}
		
		public function SceneGraphNode(actor:IDisplayable) 
		{
			this.actor = actor;
			children = new Vector.<SceneGraphNode>();
			
			if ( actor is Actor )
			{
				Actor(actor).addEventListener(ChildEvent.CHILD_ADDED, onChildAdded);
				Actor(actor).addEventListener(ChildEvent.CHILD_REMOVED, onChildRemoved);
				
				for (var x:int = 0; x < Actor(actor).numChildren; x++)
				{
					children.push(new SceneGraphNode(Actor(actor).Children[x]));
				}
			}
		}
		
		public function get isVisible():Boolean
		{
			return actor.IsVisible;
		}
		
		private function onChildAdded(event:ChildEvent):void
		{
			children.push(new SceneGraphNode((IDisplayable)(event.childActor)));
		}
		
		private function onChildRemoved(event:ChildEvent):void
		{
			for ( var x:int = 0; x < children.length; x++ )
			{
				if ( children[x].actor == (IDisplayable)(event.childActor) )
				{
					if ( children[x].actor is Actor )
					{
						children[x].dispose();
					}
					
					break;
				}
			}
			
			if ( x < children.length )
			{
				children.splice(x, 1);
			}
		}
		
		private function dispose():void
		{
			Actor(actor).removeEventListener(ChildEvent.CHILD_ADDED, onChildAdded);
			Actor(actor).removeEventListener(ChildEvent.CHILD_REMOVED, onChildRemoved);
			
			for ( var x:int = 0; x < children.length; x++ )
			{
				children[x].dispose();
			}
			
			children.splice(0, children.length);
		}
	}
}