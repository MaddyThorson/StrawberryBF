using System;
using System.Collections;

namespace Strawberry
{
	public abstract class Geometry : Entity
	{
		private Vector remainder;

		public this(Point position)
			: base(position)
		{

		}

		public void MoveX(float amount)
		{
			remainder.X += amount;
			let move = (int)Math.Round(remainder.X);
			if (move != 0)
			{
				remainder.X -= move;
				MoveExactX(move);
			}
		}

		public void MoveY(float amount)
		{
			remainder.Y += amount;
			let move = (int)Math.Round(remainder.Y);
			if (move != 0)
			{
				remainder.Y -= move;
				MoveExactY(move);
			}
		}

		public abstract void MoveExactX(int amount);
		public abstract void MoveExactY(int amount);
		public abstract List<Actor> GetRiders(List<Actor> into);

		public void ZeroRemainderX()
		{
			remainder.X = 0;
		}

		public void ZeroRemainderY()
		{
			remainder.Y = 0;
		}

		public void ZeroRemainders()
		{
			remainder = Vector.Zero;
		}
	}
}
