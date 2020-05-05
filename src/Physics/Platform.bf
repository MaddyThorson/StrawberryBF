using System;
using System.Collections;

namespace Strawberry
{
	public abstract class Platform : Entity
	{
		private Vector remainder;

		public this(int x, int y)
			: base(x, y)
		{

		}

		public void MoveX(float amount, Action onCollide = null)
		{
			remainder.X += amount;
			let move = (int)Math.Round(remainder.X);
			if (move != 0)
			{
				remainder.X -= move;
				MoveExactX(move, onCollide);
			}
		}

		public void MoveY(float amount, Action onCollide = null)
		{
			remainder.Y += amount;
			let move = (int)Math.Round(remainder.Y);
			if (move != 0)
			{
				remainder.Y -= move;
				MoveExactY(move, onCollide);
			}
		}

		public abstract void MoveExactX(int amount, Action onCollide = null);
		public abstract void MoveExactY(int amount, Action onCollide = null);
		public abstract List<Actor> GetRiders(List<Actor> into);

		public void ZeroRemainderX()
		{
			remainder.X = 0;
		}

		public void ZeroRemainderY()
		{
			remainder.Y = 0;
		}

		public void ZeroRemainder()
		{
			remainder = Vector.Zero;
		}
	}
}
