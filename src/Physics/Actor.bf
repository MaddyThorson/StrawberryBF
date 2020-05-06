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
			Scene.Remove(this);
		}

		public bool MoveX(float amount, Action<Collision> onCollide = null)
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

		public bool MoveY(float amount, Action<Collision> onCollide = null)
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

		public bool MoveExactX(int amount, Action<Collision> onCollide = null, Geometry pusher = null)
		{
			int move = amount;
			int sign = Math.Sign(amount);
			while (move != 0)
			{
				let hit = First<Solid>(.(sign, 0));
				if (hit != null)
				{
					ZeroRemainderX();

					let c = Collision(
						Point.Right * sign,
						Math.Abs(amount),
						Math.Abs(amount - move),
						hit,
						pusher
					);

					onCollide?.Invoke(c);
					return true;
				}

				X += sign;
				move -= sign;
			}

			return false;
		}

		public bool MoveExactY(int amount, Action<Collision> onCollide = null, Geometry pusher = null)
		{
			int move = amount;
			int sign = Math.Sign(amount);
			while (move != 0)
			{
				let hit = First<Solid>(.(0, sign));
				if (hit != null)
				{
					ZeroRemainderY();

					let c = Collision(
						Point.Right * sign,
						Math.Abs(amount),
						Math.Abs(amount - move),
						hit,
						pusher
					);

					onCollide?.Invoke(c);
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

		public void ZeroRemainders()
		{
			remainder = Vector.Zero;
		}
	}
}
