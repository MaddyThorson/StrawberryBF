using System;

namespace Strawberry
{
	public struct Vector
	{
		static public readonly Vector Right = Vector(1, 0);
		static public readonly Vector Left = Vector(-1, 0);
		static public readonly Vector Up = Vector(0, -1);
		static public readonly Vector Down = Vector(0, 1);
		static public readonly Vector Zero = Vector(0, 0);
		static public readonly Vector One = Vector(1, 1);

		public float X;
		public float Y;

		public this()
		{
			this = default;
		}

		public this(float x, float y)
		{
			X = x;
			Y = y;
		}

		public float Length
		{
			[Inline]
			get
			{
				return Math.Sqrt(LengthSquared);
			}
		}

		public float LengthSquared
		{
			[Inline]
			get
			{
				return X * X + Y * Y;
			}
		}

		[Inline]
		public Point Round()
		{
			return Point((int)Math.Round(X), (int)Math.Round(Y));
		}

		static public operator Vector(Point a)
		{
			return Vector(a.X, a.Y);
		}

		static public bool operator==(Vector a, Vector b)
		{
			return a.X == b.X && a.Y == b.Y;
		}

		static public Vector operator+(Vector a, Vector b)
		{
			return Vector(a.X + b.X, a.Y + b.Y);
		}

		static public Vector operator-(Vector a, Vector b)
		{
			return Vector(a.X - b.X, a.Y - b.Y);
		}

		static public Vector operator*(Vector a, float b)
		{
			return Vector(a.X * b, a.Y * b);
		}

		static public Vector operator/(Vector a, float b)
		{
			return Vector(a.X / b, a.Y / b);
		}
	}
}
