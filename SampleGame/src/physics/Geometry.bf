using System;
using System.Collections;

namespace Strawberry.Sample
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

		[Inline]
		public void Move(Vector amount)
		{
			MoveX(amount.X);
			MoveY(amount.Y);
		}

		[Inline]
		public void MoveToX(float x)
		{
			MoveX(x - (X + remainder.X));
		}

		[Inline]
		public void MoveToY(float y)
		{
			MoveY(y - (Y + remainder.Y));
		}

		[Inline]
		public void MoveTo(Vector target)
		{
			MoveToX(target.X);
			MoveToY(target.Y);
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
