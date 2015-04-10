package engine.events 
{
	import engine.weaponsystem.AbstractBullet;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class BulletCreatedEvent extends Event 
	{
		public static const BULLET_CREATED:String = "bulletCreated";
		
		public var bullet:AbstractBullet;
		
		public function BulletCreatedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new BulletCreatedEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("BulletCreatedEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}