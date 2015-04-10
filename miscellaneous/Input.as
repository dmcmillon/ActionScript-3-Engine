package engine.miscellaneous 
{
	
	import flash.display.Stage;
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
		private var oneKey:Boolean = false;
		private var twoKey:Boolean = false;
		private var threeKey:Boolean = false;
		private var fourKey:Boolean = false;
		private var fiveKey:Boolean = false;
		private var sixKey:Boolean = false;
		private var sevenKey:Boolean = false;
		private var eightKey:Boolean = false;
		private var nineKey:Boolean = false;
		private var shiftKey:Boolean = false;
		
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
		public function get OneKey():Boolean { return oneKey; }
		public function get TwoKey():Boolean { return twoKey; }
		public function get ThreeKey():Boolean { return threeKey; }
		public function get FourKey():Boolean { return fourKey; }
		public function get FiveKey():Boolean { return fiveKey; }
		public function get SixKey():Boolean { return sixKey; }
		public function get SevenKey():Boolean { return sevenKey; }
		public function get EightKey():Boolean { return eightKey; }
		public function get NineKey():Boolean { return nineKey; }
		public function get ShiftKey():Boolean { return shiftKey; }
		
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
			
			if ( event.keyCode == 38 ) { upKey = false; }
			if ( event.keyCode == 40 ) { downKey = false; }	
			if ( event.keyCode == 37 ) { leftKey = false; }	
			if ( event.keyCode == 39 ) { rightKey = false; }
			if ( event.keyCode == 32 ) { spaceKey = false; }
			if ( event.keyCode == 49 ) { oneKey = false; }
			if ( event.keyCode == 50 ) { twoKey = false; }
			if ( event.keyCode == 51 ) { threeKey = false; }
			if ( event.keyCode == 52 ) { fourKey = false; }
			if ( event.keyCode == 53 ) { fiveKey = false; }
			if ( event.keyCode == 54 ) { sixKey = false; }
			if ( event.keyCode == 55 ) { sevenKey = false; }
			if ( event.keyCode == 56 ) { eightKey = false; }
			if ( event.keyCode == 57 ) { nineKey = false; }
			if ( event.keyCode == 13 ) { enterKey = false; }
			if ( event.keyCode == 87 ) { wKey = false; }	
			if ( event.keyCode == 65 ) { aKey = false; }	
			if ( event.keyCode == 83 ) { sKey = false; }	
			if ( event.keyCode == 68 ) { dKey = false; }
			if ( event.keyCode == 16 ) { shiftKey = false; }
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			wasKeyPressed = true;
			if ( event.keyCode == 38 ) { upKey = true; }
			if ( event.keyCode == 40 ) { downKey = true; }	
			if ( event.keyCode == 37 ) { leftKey = true; }	
			if ( event.keyCode == 39 ) { rightKey = true; }	
			if ( event.keyCode == 32 ) { spaceKey = true; }
			if ( event.keyCode == 13 ) { enterKey = true; }
			if ( event.keyCode == 49 ) { oneKey = true; }
			if ( event.keyCode == 50 ) { twoKey = true; }
			if ( event.keyCode == 51 ) { threeKey = true; }
			if ( event.keyCode == 52 ) { fourKey = true; }
			if ( event.keyCode == 53 ) { fiveKey = true; }
			if ( event.keyCode == 54 ) { sixKey = true; }
			if ( event.keyCode == 55 ) { sevenKey = true; }
			if ( event.keyCode == 56 ) { eightKey = true; }
			if ( event.keyCode == 57 ) { nineKey = true; }
			if ( event.keyCode == 13 ) { enterKey = true; }
			if ( event.keyCode == 87 ) { wKey = true; }	
			if ( event.keyCode == 65 ) { aKey = true; }	
			if ( event.keyCode == 83 ) { sKey = true; }	
			if ( event.keyCode == 68 ) { dKey = true; }
			if ( event.keyCode == 16 ) { shiftKey = true; }				
		}
	}
}	

internal class MakeSingleton
{
	public function MakeSingleton() {}
}
