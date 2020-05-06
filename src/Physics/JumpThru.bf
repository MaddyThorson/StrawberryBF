using System.Collections;
namespace Strawberry
{
	public class JumpThru : Geometry
	{
		public this(Point position, int width)
			: base(position)
		{
			Hitbox = Rect(0, 0, width, 6);
		}

		public override void MoveExactX(int amount)
		{
			let riders = GetRiders(scope List<Actor>);

			X += amount;
			for (var r in riders)
				r.MoveExactX(amount);
		}

		public override void MoveExactY(int amount)
		{
			let riders = GetRiders(scope List<Actor>);
		}

		public override List<Actor> GetRiders(List<Actor> into)
		{
			for (var a in Scene.All<Actor>(scope List<Actor>))
				if (a.IsRiding(this))
					into.Add(a);
			return into;
		}

		public override void Draw()
		{
			DrawHitbox(.(255, 255, 255, 255));
		}
	}
}
