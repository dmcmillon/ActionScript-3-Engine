package engine.levels 
{
	import engine.events.LevelEvents;
	import engine.miscellaneous.ITickable;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class LevelManager extends EventDispatcher implements ITickable
	{
		public static const LEVELS_COMPLETED:String = "levelsCompleted";
	
		private var levels:Vector.<ILevel>;
		private var completedLevels:Vector.<ILevel>;
		
		private var sequentialLevels:Boolean;
		
		private var currentLevel:int = 0;
		private var maxLevels:int = 0;
		
		public function LevelManager(sequentialLevels:Boolean) 
		{
			super();
			
			this.sequentialLevels = sequentialLevels;
			
			levels = new Vector.<ILevel>();
			
			completedLevels =  ( !sequentialLevels ) ? new Vector.<ILevel>() : null;
		}
		
		public function addLevel(level:ILevel):void
		{
			levels.push(level);
		}
		
		public function addGroupOfLevels(newLevels:Vector.<ILevel>):void
		{
			levels.concat(newLevels);
		}
		
		public function startLevel():void
		{
			//if levels are played sequentially load the next level.
			if ( sequentialLevels )
			{
				levels[currentLevel].setup();
				levels[currentLevel].addEventListener(LevelEvents.LEVEL_COMPLETE, onLevelComplete);
				levels[currentLevel].addEventListener(LevelEvents.LEVEL_INCOMPLETE, onLevelIncomplete);
			}
			//if not load a random level.
			else
			{
				currentLevel = Math.floor(Math.random() * (levels.length-1));
				levels[currentLevel].setup();
				levels[currentLevel].addEventListener(LevelEvents.LEVEL_COMPLETE, onLevelComplete);
				levels[currentLevel].addEventListener(LevelEvents.LEVEL_INCOMPLETE, onLevelIncomplete);
			}
		}
		
		public function nextLevel():void
		{
			levels[currentLevel].teardown();
			levels[currentLevel].removeEventListener(LevelEvents.LEVEL_COMPLETE, onLevelComplete);
			levels[currentLevel].removeEventListener(LevelEvents.LEVEL_INCOMPLETE, onLevelIncomplete);
			
			if ( completedLevels != null )
			{
				var level:Vector.<ILevel> = levels.splice(currentLevel, 1);
				completedLevels.push(level.pop());
			}
			
			currentLevel++;
			
			//checks if all the levels have been played
			if ( levels.length == 0 || (currentLevel > levels.length && sequentialLevels) )
			{
				dispatchEvent(new Event(LevelManager.LEVELS_COMPLETED));
			}
			else
			{
				startLevel();
			}
		}
		
		public function tick(deltaTime:Number):void
		{
			levels[currentLevel].tick(deltaTime);
		}
		
		private function onLevelComplete(event:LevelEvents):void
		{
			nextLevel();
		}
		
		private function onLevelIncomplete(event:LevelEvents):void
		{
			dispatchEvent(event);
		}
		
	}

}