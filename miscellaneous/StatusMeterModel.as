package engine.miscellaneous 
{
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class StatusMeterModel 
	{
		private var currentValue:Number;
		private var maxValue:Number;
		
		public function get MaxValue():Number
		{
			return maxValue;
		}
		
		public function get CurrentValue():Number
		{
			return currentValue;
		}
		
		public function StatusMeterModel(startingValue:Number, maxValue:Number) 
		{
			currentValue = startingValue;
			this.maxValue = maxValue;
		}
		
		public function increaseValue(amount:Number):void
		{
			currentValue += amount;
		}
		
		public function decreaseValue(amount:Number):void
		{
			currentValue -= amount;
		}
		
		public function increaseMaxValue(amount:Number):void
		{
			maxValue += amount;
		}
		
		public function decreaseMaxValue(amount:Number):void
		{
			maxValue -= amount;
		}
	}
}