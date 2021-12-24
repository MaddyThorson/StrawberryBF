using System.Collections;
using System.Collections;

namespace Strawberry.Sample
{
	public class JumpThru : Component, IHasHitbox
	{
		public Hitbox Hitbox { get; private set; }

		private Vector remainder;

		public Vector ExactPosition => Entity.Position + remainder;

		public this(Hitbox hitbox)
		{
			Hitbox = hitbox;
		}

		public void FindRiders(List<Actor> into)
		{
			for (let a in Scene.All<Actor>(scope .()))
				if (a.IsRiding(this))
					into.Add(a);
		}

		public void Move(Vector amount)
		{
			remainder += amount;
			Point move = remainder.Round();
			MoveExact(move);
		}

		public void MoveTo(Vector pos)
		{
			Move(pos - ExactPosition);
		}

		public void MoveExact(Point amount)
		{
			if (amount != .Zero)
			{
				if (Hitbox.Collidable)
				{
					List<Actor> riders = FindRiders(..scope .());
					Hitbox.Collidable = false;
	
					for (let r in riders)
					{
						r.MoveExactX(amount.X);
						r.MoveExactY(amount.Y);
					}
	
					Hitbox.Collidable = true;
				}

				Entity.Position += amount;
			}
		}
	}
}
