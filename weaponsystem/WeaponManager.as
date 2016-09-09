package engine.weaponsystem 
{
	import engine.collision.CollisionManager;
	import engine.events.BulletCreatedEvent;
	import engine.events.IndexOutOfRange;
	import engine.math.Vector2D;
	import engine.miscellaneous.ITickable;
	import flash.display.Sprite;
	import flash.display.Stage;
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
		
		private var gameWorld:Sprite;
		private var _owner:Sprite;
		
		private var tickables:Vector.<ITickable>;
		private var collisionManager:CollisionManager;
		
		private var maxSize:int;	//The maximum number of weapons that can be held at one time.
		
		private var isMaxSize:Boolean; 	//Flag that specifies whether the manager has a max size or not.
		
		public function WeaponManager(owner:Sprite, maxSize:int = 0) 
		{
			owner.addEventListener(Event.ADDED_TO_STAGE, onPlayerAddedToStage);
			
			this.maxSize = maxSize;
			isMaxSize = (maxSize > 0) ? true : false;
			
			_owner = owner;
			
			equippedWeapons = new Vector.<AbstractFiringWeapon>();
			
			tickables = new Vector.<ITickable>();
			collisionManager = CollisionManager.getInstance();
		}
		
		public function canAddWeapon():Boolean
		{
			return !isMaxSize || (equippedWeapons.length < maxSize);
		}
		
		public function addWeapon(weapon:AbstractFiringWeapon):void
		{
			if ( isMaxSize && equippedWeapons.length == maxSize )
			{
				throw new Error("Weapon Inventory is full!");
			}
			
			equippedWeapons.push(weapon);
			
			if ( currentWeapon == null )
			{
				currentWeaponIndex = 0;
				currentWeapon = equippedWeapons[currentWeaponIndex];
				currentWeapon.addEventListener(BulletCreatedEvent.BULLET_CREATED, onBulletCreated);
				
				_owner.addChild(currentWeapon);
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
			_owner.removeChild(currentWeapon);
			currentWeaponIndex = index;
			currentWeapon = equippedWeapons[currentWeaponIndex];
			currentWeapon.setup();
			currentWeapon.addEventListener(BulletCreatedEvent.BULLET_CREATED, onBulletCreated);
			_owner.addChild(currentWeapon);
		}
		
		public function removeWeapon(index:int):void
		{
			if ( isIndexInRange(index) )
			{
				if ( index == currentWeaponIndex )
				{
					currentWeapon.removeEventListener(BulletCreatedEvent.BULLET_CREATED, onBulletCreated);
					_owner.removeChild(currentWeapon);
					
					//If the current weapon is not the last weapon in the list, equip the next weapon in the list. If it is, set currentWeapon to null.
					if ( equippedWeapons.length > 1 )
					{
						currentWeapon = equippedWeapons[(currentWeaponIndex + 1) % equippedWeapons.length];
						currentWeapon.addEventListener(BulletCreatedEvent.BULLET_CREATED, onBulletCreated);
						_owner.addChild(currentWeapon);
						
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
			
			removeBullets();
		}
		
		private function removeBullets():void
		{
			for ( var x:int = 0; x < tickables.length; x++ )
			{
				var bullet:IBullet = tickables[x] as IBullet;
				
				if ( !bullet.isAlive() )
				{
					tickables.splice(x, 1);
					x--;
					collisionManager.removeCollider(bullet);
				}
			}
		}
		
		private function isIndexInRange(index:int):Boolean
		{
			return ((index >= 0) && (index < equippedWeapons.length));
		}
		
		private function onBulletCreated(event:BulletCreatedEvent):void
		{
			var bullet:Sprite = event.bullet as Sprite;
			gameWorld.addChild(bullet);
			
			tickables.push(event.bullet);
			collisionManager.addCollider(event.bullet);
		}
		
		private function onPlayerAddedToStage(event:Event):void
		{
			_owner.removeEventListener(Event.ADDED_TO_STAGE, onPlayerAddedToStage);
			gameWorld = _owner.parent as Sprite;
		}
	}
}