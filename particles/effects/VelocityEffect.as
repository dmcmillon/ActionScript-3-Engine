package engine.particles.effects 
{
	import engine.particles.Particle;
	/**
	 * Effect that applies velocity to a particle.
	 * @author Daniel McMillon
	 */
	public class VelocityEffect implements IParticleEffect
	{
		public function effect(particle:Particle, deltaTime:Number):void
		{
			particle.x += particle.velocity.x * deltaTime;
			particle.y += particle.velocity.y * deltaTime;
		}
	}
}