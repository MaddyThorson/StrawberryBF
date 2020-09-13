
namespace Strawberry.Sample
{
	public struct Collision
	{
		public Cardinals Direction;
		public int Magnitude;
		public int Completed;
		public Geometry Stopper;
		public Geometry Pusher;

		public this(Cardinals direction, int magnitude, int completed, Geometry stopper, Geometry pusher)
		{
			Direction = direction;
			Magnitude = magnitude;
			Completed = completed;
			Stopper = stopper;
			Pusher = pusher;
		}
	}
}
