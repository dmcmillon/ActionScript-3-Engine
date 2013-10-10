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
		private static var instance:ScreenManager;
		
		private var screenStack:Vector.<IGameScreen>;
		
		public static function getInstance():ScreenManager
		{
			if ( instance == null )
			{
				instance = new ScreenManager(new MakeSingleton());
			}
			
			return instance;
		}
		
		public function ScreenManager(dummy:MakeSingleton)
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
			screenStack[screenStack.length - 1].tick(deltaTime);
		}
		
		public function newScreenListener(event:ChangeScreenEvent):void
		{
			if ( IGameScreen(event.nextScreen) == screenStack[screenStack.length - 1] )
			{
				return;
			}
			
			removeScreen();
			addScreen((IGameScreen)(event.nextScreen));
		}
		
		public function newOverlayScreen(event:ChangeScreenEvent):void
		{
			if ( IGameScreen(event.nextScreen) == screenStack[screenStack.length - 1] )
			{
				return;
			}
			
			screenStack[screenStack.length - 1].sleep();
			addScreen((IGameScreen)(event.nextScreen));
		}
		
		public function removeOverlayScreen(event:ChangeScreenEvent):void
		{
			removeScreen();
			screenStack[screenStack.length - 1].setup();
		}
	}
}

internal class MakeSingleton
{
	public function MakeSingleton()	{}
}