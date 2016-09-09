package engine.collision 
{
	
	/**
	 * ...
	 * @author Daniel
	 */
	public interface IBoundingVolume 
	{
		function intersects(volume:IBoundingVolume):Boolean;
	}
	
}