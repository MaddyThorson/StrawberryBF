using System;

namespace Strawberry
{
	[Reflect]
	public class Actor : Entity
	{
		private Vector remainder;

		public this(int x, int y)
			: base(x, y)
		{

		}

		public bool GroundCheck(int distance = 1)
		{
			return Check<Solid>(.(0, distance));
		}

		public virtual bool IsRiding(Solid solid)
		{
			return Check(solid, .(0, 1));
		}

		public virtual void Squish()
		{

		}

		public bool MoveX(float amount, Action onCollide = null)
		{
			remainder.X += amount;
			let move = (int)Math.Round(remainder.X);
			if (move != 0)
			{
				remainder.X -= move;
				return MoveExactX(move, onCollide);
			}
			else
				return false;
		}

		public bool MoveY(float amount, Action onCollide = null)
		{
			remainder.Y += amount;
			let move = (int)Math.Round(remainder.Y);
			if (move != 0)
			{
				remainder.Y -= move;
				return MoveExactY(move, onCollide);
			}
			else
				return false;
		}

		public bool MoveExactX(int amount, Action onCollide = null)
		{
			int move = amount;
			int sign = Math.Sign(amount);
			while (move != 0)
			{
				if (Check<Solid>(.(sign, 0)))
				{
					ZeroRemainderX();
					onCollide?.Invoke();
					return true;
				}

				X += sign;
				move -= sign;
			}

			return false;
		}

		public bool MoveExactY(int amount, Action onCollide = null)
		{
			int move = amount;
			int sign = Math.Sign(amount);
			while (move != 0)
			{
				if (Check<Solid>(.(0, sign)))
				{
					ZeroRemainderY();
					onCollide?.Invoke();
					return true;
				}

				Y += sign;
				move -= sign;
			}

			return false;
		}

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
