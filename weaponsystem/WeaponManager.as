package engine.weaponsystem 
{
	import engine.events.IndexOutOfRange;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Daniel McMillon
	 */
	public class WeaponManager extends Sprite 
	{
		private var currentWeaponIndex:int = 0;
		private var currentWeapon:AbstractFiringWeapon;
		private var equippedWeapons:Vector.<AbstractFiringWeapon>;
		
		public function WeaponManager() 
		{
			equippedWeapons = new Vector.<AbstractFiringWeapon>();
		}
		
		public function addWeapon(weapon:AbstractFiringWeapon):void
		{
			equippedWeapons.push(weapon);
			
			if ( currentWeapon == null )
			{
				currentWeaponIndex = 0;
				currentWeapon = equippedWeapons[0];
				addChild(currentWeapon);
				currentWeapon.setup();
			}
		}
		
		public function switchWeapon(index:int):void
		{
			if ( !isIndexInRange(index) ) { throw new Error("Index Out of Range!"); }
			
			changeWeapon(index);
		}
		
		public function nextWeapon():void
		{
			changeWeapon((currentWeaponIndex + 1) % equippedWeapons.length);
		}
		
		private function changeWeapon(index:int):void 
		{
			removeChild(currentWeapon);
			currentWeapon.teardown();
			currentWeaponIndex = index;
			currentWeapon = equippedWeapons[currentWeaponIndex];
			currentWeapon.setup();
			addChild(currentWeapon);
		}
		
		public function removeWeapon(index:int):void
		{
			if ( !isIndexInRange(index) ) { throw new Error("Index Out of Range!"); }
			
			if ( index == currentWeaponIndex )
			{
				removeChild(equippedWeapons[currentWeaponIndex]);
				
				//If the current weapon is not the last weapon in the list, equip the next weapon in the list. If it is, set currentWeapon to null.
				currentWeaponIndex = (equippedWeapons.length > 1) ? (currentWeaponIndex + 1) % equippedWeapons.length : -1;
				
				if (currentWeaponIndex >= 0 )
				{
					currentWeapon = equippedWeapons[currentWeaponIndex];
					addChild(currentWeapon);
				}
				else
				{
					currentWeapon = null;
				}
			}
			
			equippedWeapons.splice(index, 1);
		}
		
		public function fire():void
		{
			currentWeapon.fire();
		}
		
		public function tick(deltaTime:Number):void
		{
			currentWeapon.tick(deltaTime);
		}
		
		private function isIndexInRange(index:int):Boolean
		{
			return (index < 0 || index > equippedWeapons.length);
		}
	}
}