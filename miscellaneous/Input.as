package engine.miscellaneous 
{
	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class Input extends EventDispatcher
	{
		private static var instance:Input;
		
		private var upKey:Boolean = false;
		private var downKey:Boolean = false;
		private var leftKey:Boolean = false;
		private var rightKey:Boolean = false;
		private var spaceKey:Boolean = false;
		private var enterKey:Boolean = false;
		private var wKey:Boolean = false;
		private var aKey:Boolean = false;
		private var sKey:Boolean = false;
		private var dKey:Boolean = false;
		private var rKey:Boolean = false;
		
		private var wasKeyPressed:Boolean = false;
		
		public function get WasKeyPressed():Boolean { return wasKeyPressed;	}
		
		public function get Up():Boolean { return upKey; }
		public function get Down():Boolean { return downKey; }
		public function get Left():Boolean { return leftKey; }
		public function get Right():Boolean { return rightKey; }
		public function get Space():Boolean { return spaceKey; }
		public function get Enter():Boolean { return enterKey; }
		public function get W():Boolean { return wKey; }
		public function get A():Boolean { return aKey; }
		public function get S():Boolean { return sKey; }
		public function get D():Boolean { return dKey; }
		public function get R():Boolean { return rKey; }
		
		public static function getInstance():Input
		{
			if ( instance == null )
			{
				instance = new Input(new MakeSingleton());
			}
			 
			return instance;
		}
		
		public function Input(dummy:MakeSingleton)
		{
			addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			wasKeyPressed = false;
			
			if ( event.keyCode == Keyboard.UP ) { upKey = false; }
			if ( event.keyCode == Keyboard.DOWN ) { downKey = false; }	
			if ( event.keyCode == Keyboard.LEFT ) { leftKey = false; }	
			if ( event.keyCode == Keyboard.RIGHT ) { rightKey = false; }
			if ( event.keyCode == Keyboard.SPACE ) { spaceKey = false; }
			if ( event.keyCode == Keyboard.ENTER ) { enterKey = false; }
			if ( event.keyCode == Keyboard.W ) { wKey = false; }	
			if ( event.keyCode == Keyboard.A ) { aKey = false; }	
			if ( event.keyCode == Keyboard.S ) { sKey = false; }	
			if ( event.keyCode == Keyboard.D ) { dKey = false; }
			if ( event.keyCode == Keyboard.R ) { rKey = false; }
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			wasKeyPressed = true;
			
			if ( event.keyCode == Keyboard.UP ) { upKey = true; }
			if ( event.keyCode == Keyboard.DOWN ) { downKey = true; }	
			if ( event.keyCode == Keyboard.LEFT ) { leftKey = true; }	
			if ( event.keyCode == Keyboard.RIGHT ) { rightKey = true; }	
			if ( event.keyCode == Keyboard.SPACE ) { spaceKey = true; }
			if ( event.keyCode == Keyboard.ENTER ) { enterKey = true; }
			if ( event.keyCode == Keyboard.W ) { wKey = true; }	
			if ( event.keyCode == Keyboard.A ) { aKey = true; }	
			if ( event.keyCode == Keyboard.S ) { sKey = true; }	
			if ( event.keyCode == Keyboard.D ) { dKey = true; }
			if ( event.keyCode == Keyboard.R ) { rKey = true; }
		}
	}
}	

internal class MakeSingleton
{
	public function MakeSingleton() {}
}
