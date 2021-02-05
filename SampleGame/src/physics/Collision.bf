
namespace Strawberry.Sample
{
	public struct Collision
	{
		public Cardinals Direction;
		public int Magnitude;
		public int Completed;

		public this(Cardinals direction, int magnitude, int completed)
		{
			Direction = direction;
			Magnitude = magnitude;
			Completed = completed;
		}
	}
}
