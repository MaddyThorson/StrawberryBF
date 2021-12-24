using System;
using System.Collections;

namespace Strawberry.Sample
{
	public class Actor : Component, IHasHitbox, IUpdate
	{
		public Hitbox Hitbox { get; private set; }
		public Vector Speed;

		private Vector remainder;

		public Level Level => Entity.SceneAs<Level>();
		public Vector ExactPosition => Entity.Position + remainder;

		public this(Hitbox hitbox)
		{
			Hitbox = hitbox;
		}

		public void Update()
		{
			MoveX(Speed.X * Time.Delta);
			MoveY(Speed.Y * Time.Delta);
		}

		/*
			Collision Helpers
		*/

		public bool Check(Level level)
		{
			return level.SolidGrid != null && Hitbox.Check(level.SolidGrid);
		}

		public bool Check(Level level, Point offset)
		{
			return level.SolidGrid != null && Hitbox.Check(level.SolidGrid, offset);
		}

		public bool GroundCheck(int distance = 1)
		{
			return Hitbox.Check<Solid>(.(0, distance)) || Check(Level, .(0, distance)) || Hitbox.CheckOutside<JumpThru>(.(0, distance));
		}

		public bool IsRiding(Solid solid)
		{
			return Hitbox.Check(solid, .(0, 1));
		}

		public bool IsRiding(JumpThru jumpThru)
		{
			return Hitbox.CheckOutside(jumpThru, .(0, 1));
		}

		/*
			Movement
		*/

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
		public void MoveToX(float x, delegate void(Collision) onCollide = null)
		{
			MoveX(x - (Entity.X + remainder.X), onCollide);
		}

		[Inline]
		public void MoveToY(float y, delegate void(Collision) onCollide = null)
		{
			MoveY(y - (Entity.Y + remainder.Y), onCollide);
		}

		public bool MoveExactX(int amount, delegate void(Collision) onCollide = null)
		{
			int move = amount;
			int sign = Math.Sign(amount);

			while (move != 0)
			{
				if (Check(Level, .(sign, 0)) || Hitbox.Check<Solid>(.(sign, 0)))
				{
					let c = Collision(
						Cardinals.FromPoint(Point.Right * sign),
						Math.Abs(amount),
						Math.Abs(amount - move)
					);

					onCollide?.Invoke(c);
					return true;
				}

				Entity.X += sign;
				move -= sign;
			}

			return false;
		}

		public bool MoveExactY(int amount, delegate void(Collision) onCollide = null)
		{
			int move = amount;
			int sign = Math.Sign(amount);

			if (move > 0)
			{
				while (move != 0)
				{
					if (Check(Level, .(0, sign)) || Hitbox.Check<Solid>(.(0, sign)) || Hitbox.CheckOutside<JumpThru>(.(0, sign)))
					{
						let c = Collision(
							Cardinals.FromPoint(Point.Down * sign),
							Math.Abs(amount),
							Math.Abs(amount - move)
						);

						onCollide?.Invoke(c);
						return true;
					}

					Entity.Y += sign;
					move -= sign;
				}
			}
			else
			{
				while (move != 0)
				{
					if (Check(Level, .(0, sign)) || Hitbox.Check<Solid>(.(0, sign)))
					{
						let c = Collision(
							Cardinals.FromPoint(Point.Down * sign),
							Math.Abs(amount),
							Math.Abs(amount - move)
						);

						onCollide?.Invoke(c);
						return true;
					}

					Entity.Y += sign;
					move -= sign;
				}
			}

			return false;
		}

		[Inline]
		public void ZeroRemainderX()
		{
			remainder.X = 0;
		}

		[Inline]
		public void ZeroRemainderY()
		{
			remainder.Y = 0;
		}

		[Inline]
		public void ZeroRemainders()
		{
			remainder = Vector.Zero;
		}

		public bool CornerCorrection(Cardinals direction, int maxAmount, int lookAhead = 1, int onlySign = 0)
		{
			Point dir = direction;
			Point perp = dir.Perpendicular();
			perp.X = Math.Abs(perp.X);
			perp.Y = Math.Abs(perp.Y);

			delegate bool(Point) checker;
			if (dir == Point.Down)
				checker = scope:: (p) => !Check(Level, p) && !Hitbox.Check<Solid>(p) && !Hitbox.CheckOutside<JumpThru>(p);
			else
				checker = scope:: (p) => !Check(Level, p) && !Hitbox.Check<Solid>(p);

			for (int i = 1; i <= maxAmount; i++)
			{
				for (int j = -1; j <= 1; j += 2)
				{
					if (onlySign != 0 && onlySign != j)
						continue;

					let offset = dir * lookAhead + perp * i * j;
					if (checker(offset))
					{
						Entity.Position += offset;
						return true;
					}	
				}
			}

			return false;
		}
	}
}
