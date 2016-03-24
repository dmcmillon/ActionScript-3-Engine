package engine.miscellaneous 
{
	import engine.gamescreens.ScreenManager;
	
	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Daniel
	 */
	public class Game extends Sprite
	{
		protected var screenManager:ScreenManager;
		protected var input:Input;
		
		protected var tickables:Vector.<ITickable>;
		
		public function Game() 
		{
			screenManager = new ScreenManager();
			addChild(screenManager);
			
			input = Input.getInstance();
			
			tickables = new Vector.<ITickable>();
			tickables.push(screenManager);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			stage.addEventListener(KeyboardEvent.KEY_UP, onInput);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onInput);
		}
		
		private function onInput(keyboardEvent:KeyboardEvent):void
		{
			input.dispatchEvent(keyboardEvent);
		}
		
		private function onEnterFrame(event:Event):void
		{
			//TODO: Calculate deltaTime.
			var deltaTime:Number = 0.1;
			
			for ( var x:int = 0; x < tickables.length; x++ )
			{
				tickables[x].tick();
			}
		}
	}
}