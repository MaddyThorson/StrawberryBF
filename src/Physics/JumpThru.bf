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

		public override void Update()
		{
			base.Update();

			MoveY(-10 * Time.Delta);
		}

		public override void MoveExactX(int amount)
		{
			if (Collidable)
			{
				let riders = GetRiders(scope List<Actor>);
	
				X += amount;
				for (var r in riders)
					r.MoveExactX(amount);
			}
			else
				X += amount;
		}

		public override void MoveExactY(int amount)
		{
			if (Collidable)
			{
				let riders = GetRiders(scope List<Actor>);

				if (amount < 0)
				{
					for (var a in Scene.All<Actor>(scope List<Actor>))
						if (riders.Contains(a) || CheckOutside(a, Point.UnitY * amount))
							a.MoveExactY((Top + amount) - a.Bottom);
					Y += amount;
				}
				else
				{
					Collidable = false;

					for (var a in riders)
						a.MoveExactY(amount);

					Collidable = true;
					Y += amount;
				}
			}
			else
				Y += amount;
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
