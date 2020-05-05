using System.Collections;

namespace Strawberry
{
	public class Solid : Platform
	{
		public this(int x, int y, Rect hitbox)
			: base(x, y)
		{
			Hitbox = hitbox;
		}

		public override void Draw()
		{
			DrawHitbox(.(255, 255, 255, 255));
		}

		public override List<Actor> GetRiders(List<Actor> into)
		{
			for (var a in Scene.All<Actor>(scope List<Actor>))
				if (a.IsRiding(this))
					into.Add(a);
			return into;
		}

		public override void MoveExactX(int amount, System.Action onCollide = null)
		{
			if (amount != 0)
			{

			}
		}

		public override void MoveExactY(int amount, System.Action onCollide = null)
		{
			if (amount != 0)
			{

			}
		}
	}
}
