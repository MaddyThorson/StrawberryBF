using System.Collections;

namespace Strawberry
{
	public class Solid : Geometry
	{
		public this(Point position, Rect hitbox)
			: base(position)
		{
			Hitbox = hitbox;
		}

		public override void Update()
		{
			base.Update();

			MoveY(0.1f);
		}

		public override List<Actor> GetRiders(List<Actor> into)
		{
			for (var a in Scene.All<Actor>(scope List<Actor>))
				if (a.IsRiding(this))
					into.Add(a);
			return into;
		}

		public override void MoveExactX(int amount)
		{
			if (Collidable)
			{
				let riders = GetRiders(scope List<Actor>);

				X += amount;
				Collidable = false;

				for (Actor a in Scene.All<Actor>(scope List<Actor>))
				{
					if (Check(a))
					{
						//Push
						int move;
						if (amount > 0)
							move = Right - a.Left;
						else
							move = Left - a.Right;
						a.MoveExactX(move, scope => a.Squish, this);
						a.Pushed += Point.UnitX * move;
					}
					else if (riders.Contains(a))
					{
						//Carry
						a.MoveExactX(amount);
						a.Pushed += Point.UnitX * amount;
					}
				}

				Collidable = true;
			}
			else
				X += amount;
		}

		public override void MoveExactY(int amount)
		{
			if (Collidable)
			{
				let riders = GetRiders(scope List<Actor>);

				Y += amount;
				Collidable = false;

				for (Actor a in Scene.All<Actor>(scope List<Actor>))
				{
					if (Check(a))
					{
						//Push
						int move;
						if (amount > 0)
							move = Bottom - a.Top;
						else
							move = Top - a.Bottom;
						a.MoveExactY(move, scope => a.Squish, this);
						a.Pushed += Point.UnitY * move;
					}
					else if (riders.Contains(a))
					{
						//Carry
						a.MoveExactY(amount);
						a.Pushed += Point.UnitY * amount;
					}
				}

				Collidable = true;
			}
			else
				Y += amount;
		}

		public override void Draw()
		{
			DrawHitbox(.(255, 255, 255, 255));
		}
	}
}
