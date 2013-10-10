package engine.particles 
{	
	/**
	 * Factory to create particles.
	 * use object pool
	 * @author Daniel McMillon
	 */
	public class ParticleFactory
	{		
		public function create():Particle
		{
			return new Particle();
		}
	}
}