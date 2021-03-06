package engine.particles
{
	import engine.display.SceneManager;
	import engine.miscellaneous.ITickable;
	import engine.maths.MathHelper;
	import engine.pool.ObjectPool;
	
	import engine.particles.effects.IParticleEffect;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	
	/**
	 * Emits and updates particles.
	 * @author Daniel McMillon
	 */

	public class ParticleEmitter implements ITickable
	{
		//x and y position of the emitter.
		public var x:Number = 0.0;
		public var y:Number = 0.0;
		
		//x and y variation of particle position in relation to emitter position.
		public var xVariation:Number = 0.0;
		public var yVariation:Number = 0.0;
		
		//maximum number of particles that can be alive at one time. If < 0 then there is no limit to the number of particles that can be alive at one time.
		public var maxParticles:int = -1;
		
		//effects applied to the particles
		public var initialEffects:Vector.<IParticleEffect>;
		public var effects:Vector.<IParticleEffect>;
		
		//Particles properties.
		//Variation variables allow for some randomness to simulate real-life.
		public var particleLifetime:int = 0;
		public var particleLifetimeVariation:int = 0;
		
		public var particleAngle:Number = 0.0;
		public var particleAngleVariation:Number = 0.0;
		
		public var particleSpeed:Number = 0.0;
		public var particleSpeedVariation:Number = 0.0;
		
		public var particleColor:uint = 0xffffff;
		public var particleColorVariation:uint = 0;
		
		public var particleRotation:Number = 0;
		public var particleRotationVariation:Number = 0;
		
		//image that the particle display on screen. If this is null, the particle draws a dot.
		//Unable to use until I figure out how to make a copy of a DisplayObject.
		public var particleGraphics:Shape;
		
		//number of particles emitted per frame
		public var emitNumber:int = 0;
		public var emitNumberVariation:int = 0;
		
		//minimum time that must pass before it's allowed to emit.
		public var emitTimer:Number = 0.0;
		
		//Flag that specifies whether the emitter has a lifetime or not. When equal to false it has a lifetime and emits for a certain number of frames.
		public var continuous:Boolean = false;
		public var emitterLifetime:int = 1;
		
		//The time that elapsed from the last emission of particles
		private var elapsed:Number = 0.0;
		
		//factory class that creates particles
		private var particleFactory:ParticleFactory;
		
		//holds a list of active particles.
		private var particleList:Vector.<Particle>;
		
		private var scenemanager:SceneManager;
		
		//A pool of the particles
		private var pool:ObjectPool;
		
		private var isAlive:Boolean;
		
		public function get IsAlive():Boolean
		{
			return isAlive;
		}
		
		public function ParticleEmitter(x:int, y:int, maxParticles:int = -1, particleGraphics:Shape = null)
		{
			this.x = x;
			this.y = y;
			
			this.particleGraphics = particleGraphics;
			this.maxParticles = maxParticles;
			particleList = new Vector.<Particle>();
			initialEffects = new Vector.<IParticleEffect>();
			//effects applied each tick.
			effects = new Vector.<IParticleEffect>();
			
			particleFactory = new ParticleFactory();
			pool = new ObjectPool(particleFactory.create);
			
			scenemanager = SceneManager.getInstance();
			
			isAlive = true;
		}
		
		public function tick(deltaTime:Number):void
		{
			//if the emitter is alive or does not die it is possible to emit.
			if ( emitterLifetime > 0 || continuous )
			{
				elapsed += deltaTime;
				
				if ( elapsed >= emitTimer )
				{
					var maxEmit:int = emitNumber + (emitNumberVariation * randomNumber());
					
					for (var emit:int = 0; emit < maxEmit; emit++ )
					{
						if ( particleList.length < maxParticles || maxParticles < 0 )
						{
							addParticle(deltaTime);
						}
						else
						{
							break;
						}
					}
					
					emitterLifetime--;
					elapsed = 0;
				}
			}
			else
			{
				if ( particleList.length == 0 )
				{
					isAlive = false;
				}
			}
			
			//apply effects to particles that are active.
			for ( var i:int = 0; i < particleList.length; i++ )
			{
				for ( var effectIndex:int = 0; effectIndex < effects.length; effectIndex++ )
				{
					effects[effectIndex].effect(particleList[i], deltaTime);
				}
					
				particleList[i].lifetime--;
			}
			
			//remove dead particles from list
			for ( i = 0; i < particleList.length; i++ )
			{				
				if ( particleList[i].lifetime < 0 ) 
				{
					scenemanager.removeFromForeground(particleList[i]);
					pool.releaseResource(particleList[i]);
					particleList.splice(i, 1);
					i--;
				}
			}
		}
		
		//creates a particle
		private function addParticle(deltaTime:Number):void
		{
			var particle:Particle = (Particle)(pool.acquireResource());
			
			particle.x = x + (xVariation * randomNumber());
			particle.y = y + (yVariation * randomNumber());
			
			var heading:Number = MathHelper.degreesToRadians(particleAngle + (particleAngleVariation * randomNumber()));
			
			var speedX:Number = particleSpeed + (particleSpeedVariation * randomNumber());
			var speedY:Number = particleSpeed + (particleSpeedVariation * randomNumber());
			
			particle.velocity.x = Math.cos(heading) * speedX;
			particle.velocity.y = Math.sin(heading) * speedY;
			
			particle.color = particleColor + (particleColorVariation * randomNumber());
			
			particle.Image = particleGraphics;
			particle.Rotation = particleRotation + (particleRotationVariation * randomNumber());
			
			particle.lifetime = particleLifetime + (particleLifetimeVariation * randomNumber());
			
			particleList.push(particle);
			scenemanager.addToForeground(particle);
			
			for ( var beginningEffectIndex:int = 0; beginningEffectIndex < initialEffects.length; beginningEffectIndex++ )
			{
				initialEffects[beginningEffectIndex].effect(particle, deltaTime);
			}
		}
		
		//used to create random values that are within a range specified by the user.
		private function randomNumber():Number
		{
			return Math.random() - Math.random();
		}
	}
}