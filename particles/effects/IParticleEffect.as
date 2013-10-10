package engine.particles.effects
{
	import engine.particles.Particle;
	/**
	 * Interface for all particle effects.
	 * @author Daniel McMillon
	 */

	public interface IParticleEffect 
	{
		function effect(particle:Particle, deltaTime:Number):void;
	}
}