package engine.gamescreens 
{
	import engine.gamescreens.IGameScreen;
	import engine.events.ChangeScreenEvent;
	import engine.miscellaneous.ITickable;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class ScreenManager implements ITickable
	{
		protected var screenStack:Vector.<IGameScreen>;
		
		public function ScreenManager()
		{
			screenStack = new Vector.<IGameScreen>;
		}
		
		public function addScreen(newScreen:IGameScreen):void
		{
			newScreen.addEventListener(ChangeScreenEvent.NEW_SCREEN, newScreenListener);
			newScreen.addEventListener(ChangeScreenEvent.OVERLAY_SCREEN, newOverlayScreen);
			newScreen.addEventListener(ChangeScreenEvent.REMOVE_OVERLAY_SCREEN, removeOverlayScreen);
			newScreen.setup();
			
			screenStack.push(newScreen);
		}
		
		public function removeScreen():void
		{
			screenStack[screenStack.length - 1].removeEventListener(ChangeScreenEvent.NEW_SCREEN, newScreenListener);
			screenStack[screenStack.length - 1].removeEventListener(ChangeScreenEvent.OVERLAY_SCREEN, newOverlayScreen);
			screenStack[screenStack.length - 1].removeEventListener(ChangeScreenEvent.REMOVE_OVERLAY_SCREEN, removeOverlayScreen);
			
			screenStack[screenStack.length - 1].teardown();
			
			screenStack.pop();
		}
		
		public function tick(deltaTime:Number):void
		{
			for ( var x:int = 0; x < screenStack.length; x++ )
			{
				screenStack[x].tick(deltaTime);
			}
		}
		
		private function passData(screen:IGameScreen, data:Array):void
		{
			if (  data.length > 0 )
			{
				IReceiveData(screen).passData(data);
			}
		}
		
		private function newScreenListener(event:ChangeScreenEvent):void
		{
			if ( event.nextScreen == screenStack[screenStack.length - 1] )
			{
				return;
			}
			
			removeScreen();
			
			if ( event.nextScreen is IReceiveData )
			{
				passData(event.nextScreen, event.extraInfo);
			}
			
			addScreen(event.nextScreen);
		}
		
		private function newOverlayScreen(event:ChangeScreenEvent):void
		{
			if ( event.nextScreen == screenStack[screenStack.length - 1] )
			{
				return;
			}
			
			if ( event.nextScreen is IReceiveData )
			{
				passData(event.nextScreen, event.extraInfo);
			}
			
			screenStack[screenStack.length - 1].sleep();
			addScreen(event.nextScreen);
		}
		
		private function removeOverlayScreen(event:ChangeScreenEvent):void
		{
			removeScreen();
			screenStack[screenStack.length - 1].setup();
		}
	}
}