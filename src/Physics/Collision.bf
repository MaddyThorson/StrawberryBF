namespace Strawberry
{
	public struct Collision
	{
		public Point Direction;
		public int Magnitude;
		public int Completed;
		public Geometry Stopper;
		public Geometry Pusher;

		public this(Point direction, int magnitude, int completed, Geometry stopper, Geometry pusher)
		{
			Direction = direction;
			Magnitude = magnitude;
			Completed = completed;
			Stopper = stopper;
			Pusher = pusher;
		}
	}
}
