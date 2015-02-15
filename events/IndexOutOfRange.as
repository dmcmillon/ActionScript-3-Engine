package engine.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class IndexOutOfRange extends Event
	{
		public static const INDEX_OUT_OF_BOUNDS:String = "IndexOutOfRange";
		
		private var index:int;
		
		public function IndexOutOfRange(index:int, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(INDEX_OUT_OF_BOUNDS, bubbles, cancelable);
			
			this.index = index;
		}
		
		public function get Index():int
		{
			return index;
		}
	}
}