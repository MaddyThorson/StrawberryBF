using System;

namespace Strawberry
{
	[Reflect]
	public class Actor : Entity
	{
		private Vector remainder;

		// The amount that geometry has pushed or carried this Actor since the last frame
		public Point MovedByGeometry { get; private set; }

		public this(Point position)
			: base(position)
		{

		}

		public bool GroundCheck(int distance = 1)
		{
			return Check<Solid>(.(0, distance)) || Check(Scene, .(0, distance)) || CheckOutside<JumpThru>(.(0, distance));
		}

		public virtual bool IsRiding(Solid solid)
		{
			return Check(solid, .(0, 1));
		}

		public virtual bool IsRiding(JumpThru jumpThru)
		{
			return CheckOutside(jumpThru, .(0, 1));
		}

		public virtual void Squish(Collision collision)
		{
			RemoveSelf();
		}

		public override void Update()
		{
			base.Update();
			MovedByGeometry = Point.Zero;
		}

		public bool MoveX(float amount, delegate void(Collision) onCollide = null)
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

		public bool MoveY(float amount, delegate void(Collision) onCollide = null)
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

		[Inline]
		public void MoveToX(float x)
		{
			MoveX(x - (X + remainder.X), null);
		}

		[Inline]
		public void MoveToY(float y)
		{
			MoveY(y - (Y + remainder.Y), null);
		}

		public bool MoveExactX(int amount, delegate void(Collision) onCollide = null, Geometry pusher = null, Geometry carrier = null)
		{
			int move = amount;
			int sign = Math.Sign(amount);
			bool byGeometry = carrier != null || pusher != null;

			while (move != 0)
			{
				let hit = First<Solid>(.(sign, 0));
				if (hit != null)
				{
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

				if (Check(Scene, .(sign, 0)))
				{
					let c = Collision(
						Point.Right * sign,
						Math.Abs(amount),
						Math.Abs(amount - move),
						null,
						pusher
					);

					onCollide?.Invoke(c);
					return true;
				}

				X += sign;
				if (byGeometry)
					MovedByGeometry.X += sign;
				move -= sign;
			}

			return false;
		}

		public bool MoveExactY(int amount, delegate void(Collision) onCollide = null, Geometry pusher = null, Geometry carrier = null)
		{
			int move = amount;
			int sign = Math.Sign(amount);
			bool byGeometry = carrier != null || pusher != null;

			while (move != 0)
			{
				Geometry hit = First<Solid>(.(0, sign));
				if (hit == null && sign == 1)
					hit = FirstOutside<JumpThru>(.(0, sign));

				if (hit != null)
				{
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

				if (Check(Scene, .(0, sign)))
				{
					let c = Collision(
						Point.Right * sign,
						Math.Abs(amount),
						Math.Abs(amount - move),
						null,
						pusher
					);

					onCollide?.Invoke(c);
					return true;
				}

				Y += sign;
				if (byGeometry)
					MovedByGeometry.Y += sign;
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

		private void MoveByGeometry(Point amount)
		{
			MovedByGeometry += amount;
		}


		public bool CornerCorrection(Cardinals direction, int maxAmount, int lookAhead = 1, int onlySign = 0)
		{
			Point dir = direction;
			Point perp = dir.Perpendicular();
			perp.X = Math.Abs(perp.X);
			perp.Y = Math.Abs(perp.Y);

			delegate bool(Point) checker;
 			if (dir == Point.Down)
				checker = scope:: (p) => !Check(Scene, p) && !Check<Solid>(p) && !CheckOutside<JumpThru>(p);
			else
				checker = scope:: (p) => !Check(Scene, p) && !Check<Solid>(p);

			for (int i = 1; i <= maxAmount; i++)
			{
				for (int j = -1; j <= 1; j += 2)
				{
					if (onlySign != 0 && onlySign != j)
						continue;

					let offset = dir * lookAhead + perp * i * j;
					if (checker(offset))
					{
						Position += offset;
						return true;
					}	
				}
			}

			return false;
		}
	}
}
