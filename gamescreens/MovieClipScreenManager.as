package engine.gamescreens 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class MovieClipScreenManager extends ScreenManager
	{
		private var stage:Stage;
		
		public function MovieClipScreenManager(stage:Stage)
		{
			super();
			
			this.stage = stage;
		}
		
		override public function addScreen(newScreen:IGameScreen):void
		{			
			super.addScreen(newScreen);
			
			if ( newScreen is DisplayObject )
			{
				stage.addChild(newScreen as DisplayObject);
			}
		}
		
		override public function removeScreen():void
		{
			var screenToRemove:IGameScreen = screenStack[screenStack.length - 1];
			
			if ( screenToRemove is DisplayObject )
			{
				stage.removeChild(screenToRemove as DisplayObject);
			}
			
			super.removeScreen();
		}
		
		override public function tick(deltaTime:Number):void
		{
			super.tick(deltaTime);
		}		
	}
}