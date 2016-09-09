package engine.gamescreens 
{
	import engine.gamescreens.IGameScreen;
	import engine.events.ChangeScreenEvent;
	import engine.miscellaneous.ITickable;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class ScreenManager extends Sprite implements ITickable
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
			addChild(newScreen as DisplayObject);
		}
		
		public function removeScreen():void
		{
			screenStack[screenStack.length - 1].removeEventListener(ChangeScreenEvent.NEW_SCREEN, newScreenListener);
			screenStack[screenStack.length - 1].removeEventListener(ChangeScreenEvent.OVERLAY_SCREEN, newOverlayScreen);
			screenStack[screenStack.length - 1].removeEventListener(ChangeScreenEvent.REMOVE_OVERLAY_SCREEN, removeOverlayScreen);
			
			removeChild(screenStack[screenStack.length - 1] as DisplayObject);
			
			screenStack[screenStack.length - 1].sleep();
			screenStack[screenStack.length - 1].teardown();
			
			screenStack.pop();
		}
		
		public function tick(deltaTime:Number):void
		{
			for ( var x:int = 0; x < screenStack.length - 1; x++ )
			{
				if ( screenStack[x].tickWhileSleep )
				{
					screenStack[x].tick(deltaTime);
				}
			}
			
			screenStack[screenStack.length - 1].tick(deltaTime);
		}
		
		private function newScreenListener(event:ChangeScreenEvent):void
		{
			if ( event.nextScreen == screenStack[screenStack.length - 1] )
			{
				return;
			}
			
			for ( var x:int = 0; x < screenStack.length; x++ )
			{
				removeScreen();
			}
			
			addScreen(event.nextScreen);
		}
		
		private function newOverlayScreen(event:ChangeScreenEvent):void
		{
			if ( event.nextScreen == screenStack[screenStack.length - 1] )
			{
				return;
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