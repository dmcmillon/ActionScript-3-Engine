package engine.weaponsystem 
{
	import engine.display.SceneManager;
	import engine.events.BulletCreatedEvent;
	import engine.events.IndexOutOfRange;
	import engine.math.Vector2D;
	import engine.miscellaneous.ITickable;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class WeaponManager extends EventDispatcher implements IEventDispatcher
	{
		private var currentWeaponIndex:int = 0;
		private var currentWeapon:AbstractFiringWeapon;
		private var equippedWeapons:Vector.<AbstractFiringWeapon>;
		
		private var sceneManager:SceneManager;
		private var tickables:Vector.<ITickable>;
		
		public function WeaponManager() 
		{
			equippedWeapons = new Vector.<AbstractFiringWeapon>();
			
			sceneManager = SceneManager.getInstance();
			tickables = new Vector.<ITickable>();
		}
		
		public function addWeapon(weapon:AbstractFiringWeapon):void
		{
			equippedWeapons.push(weapon);
			
			if ( currentWeapon == null )
			{
				currentWeaponIndex = 0;
				currentWeapon = equippedWeapons[0];
				currentWeapon.addEventListener(BulletCreatedEvent.BULLET_CREATED, onBulletCreated);
				currentWeapon.setup();
			}
		}
		
		public function switchWeapon(index:int):void
		{
			if ( isIndexInRange(index) )
				changeWeapon(index);
		}
		
		public function nextWeapon():void
		{
			if ( equippedWeapons.length > 0 )
			{
				changeWeapon((currentWeaponIndex + 1) % equippedWeapons.length);
			}
		}
		
		private function changeWeapon(index:int):void 
		{
			currentWeapon.teardown();
			currentWeapon.removeEventListener(BulletCreatedEvent.BULLET_CREATED, onBulletCreated);
			currentWeaponIndex = index;
			currentWeapon = equippedWeapons[currentWeaponIndex];
			currentWeapon.setup();
			currentWeapon.addEventListener(BulletCreatedEvent.BULLET_CREATED, onBulletCreated);
		}
		
		public function removeWeapon(index:int):void
		{
			if ( isIndexInRange(index) )
			{
				if ( index == currentWeaponIndex )
				{
					currentWeapon.removeEventListener(BulletCreatedEvent.BULLET_CREATED, onBulletCreated);
					
					//If the current weapon is not the last weapon in the list, equip the next weapon in the list. If it is, set currentWeapon to null.
					if ( equippedWeapons.length > 1 )
					{
						currentWeapon = equippedWeapons[(currentWeaponIndex+1) % equippedWeapons.length];
						currentWeapon.addEventListener(BulletCreatedEvent.BULLET_CREATED, onBulletCreated);
						
						if ( currentWeaponIndex == equippedWeapons.length - 1 )
						{
							currentWeaponIndex = 0;
						}
						
					}
					else
					{
						currentWeapon = null;
					}
				}
				
				equippedWeapons.splice(index, 1);
			}
		}
		
		public function fire(weaponPosition:Vector2D, rotationAngle:Number):void
		{
			if ( currentWeapon != null )
			{
				currentWeapon.fire(weaponPosition, rotationAngle);
			}
		}
		
		public function tick(deltaTime:Number):void
		{
			if ( currentWeapon != null )
			{
				currentWeapon.tick(deltaTime);
			}
			
			for ( var x:int = 0; x < tickables.length; x++ )
			{
				tickables[x].tick(deltaTime);
			}
		}
		
		private function onBulletCreated(event:BulletCreatedEvent):void
		{
			if ( !sceneManager.isBlitting() )
			{
				sceneManager.addToWorld(event.bullet);
				tickables.push(event.bullet);
			}
		}
		
		private function isIndexInRange(index:int):Boolean
		{
			return (index >= 0 && index < equippedWeapons.length);
		}
	}
}