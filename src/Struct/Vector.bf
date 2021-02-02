using System;

namespace Strawberry
{
	[Ordered, Packed, CRepr]
	public struct Vector
	{
		static public readonly Vector Right = .(1, 0);
		static public readonly Vector Left = .(-1, 0);
		static public readonly Vector Up = .(0, -1);
		static public readonly Vector Down = .(0, 1);
		static public readonly Vector UnitX = .(1, 0);
		static public readonly Vector UnitY = .(0, 1);
		static public readonly Vector Zero = .(0, 0);
		static public readonly Vector One = .(1, 1);

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

		public Vector Perpendicular()
		{
			return .(-Y, X);
		}

		public Vector Normalized()
		{
			if (X == 0 && Y == 0)
				return this;
			else
				return this / Length;
		}

		public float Length => Math.Sqrt(LengthSquared);
		public float LengthSquared => X * X + Y * Y;

		[Inline]
		public Point Round()
		{
			return Point((int)Math.Round(X), (int)Math.Round(Y));
		}

		static public Vector Lerp(Vector a, Vector b, float t)
		{
			if (t == 0)
				return a;
			else if (t == 1)
				return b;
			else
				return a + (b - a) * t;
		}

		public override void ToString(String strBuffer)
		{
			strBuffer.Set("Vector [ ");
			X.ToString(strBuffer);
			strBuffer.Append(", ");
			Y.ToString(strBuffer);
			strBuffer.Append(" ]");
		}

		static public operator Vector(Point a)
		{
			return Vector(a.X, a.Y);
		}

		[Commutable]
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

		static public Vector Approach(Vector value, Vector target, float maxDelta)
		{
			Vector diff = target - value;
			if (diff.Length < maxDelta)
				return target;
			else
				return value + diff.Normalized() * maxDelta;
		}

		static public void Approach(Vector* value, Vector target, float maxDelta)
		{
			*value = Approach(*value, target, maxDelta);
		}
	}
}
