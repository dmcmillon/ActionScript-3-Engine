package engine.collision.scenepartition 
{
	import engine.miscellaneous.Iterator;
	import engine.ai.Vehicle;
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class VectorVehicleIterator implements Iterator 
	{
		public var vector:Vector.<Vehicle>;
		public var index:int = 0;
		
		public function VectorVehicleIterator(vector:Vector.<Vehicle>) 
		{
			this.vector = vector;
		}
		
		public function begin():void
		{
			index = 0;
		}
		
		public function hasNext():Boolean
		{
			return ( vector[index + 1] != 0 );
		}
		
		public function next():Object
		{
			index++;
			return vector[index];
		}
	}

}