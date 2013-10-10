package engine.pool 
{
	import flash.text.TextField;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class ObjectPool 
	{
		private var usedResources:Vector.<IPoolable>;
		private var freeResources:Vector.<IPoolable>;
		private var createResource:Function;
		
		public function ObjectPool(createResource:Function) 
		{
			usedResources = new Vector.<IPoolable>();
			freeResources = new Vector.<IPoolable>();
			
			this.createResource = createResource;
		}
		
		public function acquireResource():IPoolable
		{
			var resource:IPoolable;
			
			//if there are free resources, use one
			if ( freeResources.length > 0 ) 
			{
				resource = freeResources.pop();
			}
			//if there are no free resources, create one
			else
			{
				resource = createResource();
			}
			
			resource.isAlive = true;
			usedResources.push(resource);
			return resource;
		}
		
		public function releaseResource(resource:IPoolable):void
		{
			resource.isAlive = false;
			
			for ( var i:int = 0; i < usedResources.length; i++)
			{
				if ( usedResources[i] == resource )
				{
					usedResources.splice(i, 1);
					freeResources.push(resource);
					break;
				}
			}
		}
	}
}