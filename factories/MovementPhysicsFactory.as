package engine.factories 
{
	import engine.physics.movement.SimpleMovementPhysics;
	import engine.physics.movement.BaseMovementPhysics;

	/**
	 * Factory to create physics object
	 * @author Daniel McMillon
	 */
	public class MovementPhysicsFactory
	{
		public function createSimpleMovePhysics():BaseMovementPhysics
		{
			return new SimpleMovementPhysics();
		}
	}
}