package engine.miscellaneous 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class StatusMeterView
	{
		private var meterFill:DisplayObject;
		private var meterContainer:DisplayObject;
		
		private var meterModel:StatusMeterModel;
		
		//used to cancel out scale to start from normal scalef
		private var previousMaxScale:Number;
		private var previousCurrentScale:Number;
		
		private var percentage:Number;
		
		public function StatusMeterView(model:StatusMeterModel) 
		{
			meterModel = model;
		}
		
		public function calculateMeter():void
		{
			percentage = meterModel.CurrentValue / meterModel.MaxValue;
		}
		
		public function scaleMeter():void
		{
			//reverse previous scale
			meterFill.scaleX = 1 / percentage;
			//apply new percentage
			meterFill.scaleX = percentage;
			previousCurrentScale = percentage;
		}
	}
}