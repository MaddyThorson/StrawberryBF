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

		[Inline]
		public Vector Perpendicular()
		{
			return .(-Y, X);
		}

		[Inline]
		public Vector Normalized()
		{
			if (X == 0 && Y == 0)
				return this;
			else
				return this / Length;
		}

		[Inline]
		public float Length => Math.Sqrt(LengthSquared);

		[Inline]
		public float LengthSquared => X * X + Y * Y;

		[Inline]
		public Point Round()
		{
			return .((int)Math.Round(X), (int)Math.Round(Y));
		}

		[Inline]
		public Vector Transform(Mat3x2 mat)
		{
			return Transform(this, mat);
		}

		[Inline]
		public Vector Transform(Mat4x4 mat)
		{
			return Transform(this, mat);
		}

		[Inline]
		static public Vector Lerp(Vector a, Vector b, float t)
		{
			if (t == 0)
				return a;
			else if (t == 1)
				return b;
			else
				return a + (b - a) * t;
		}

		[Inline]
		static public Vector Approach(Vector value, Vector target, float maxDelta)
		{
			Vector diff = target - value;
			if (diff.Length < maxDelta)
				return target;
			else
				return value + diff.Normalized() * maxDelta;
		}

		[Inline]
		static public void Approach(Vector* value, Vector target, float maxDelta)
		{
			*value = Approach(*value, target, maxDelta);
		}

		[Inline]
		public static Vector Transform(Vector v, Mat3x2 matrix)
		{
		    return .(
		        v.X * matrix.M11 + v.Y * matrix.M21 + matrix.M31,
		        v.X * matrix.M12 + v.Y * matrix.M22 + matrix.M32
				);
		}

		[Inline]
		public static Vector Transform(Vector v, Mat4x4 matrix)
		{
		    return .(
		        v.X * matrix.M11 + v.Y * matrix.M21 + matrix.M41,
		        v.X * matrix.M12 + v.Y * matrix.M22 + matrix.M42
				);
		}

		[Inline]
		public override void ToString(String strBuffer)
		{
			strBuffer.Set("Vector [ ");
			X.ToString(strBuffer);
			strBuffer.Append(", ");
			Y.ToString(strBuffer);
			strBuffer.Append(" ]");
		}

		[Inline]
		static public operator Vector(Point a)
		{
			return .(a.X, a.Y);
		}

		[Inline]
		static public bool operator==(Vector a, Vector b)
		{
			return a.X == b.X && a.Y == b.Y;
		}

		[Inline]
		static public Vector operator+(Vector a, Vector b)
		{
			return .(a.X + b.X, a.Y + b.Y);
		}

		[Inline]
		static public Vector operator-(Vector a, Vector b)
		{
			return .(a.X - b.X, a.Y - b.Y);
		}

		[Inline, Commutable]
		static public Vector operator*(Vector a, int b)
		{
			return .(a.X * b, a.Y * b);
		}

		[Inline, Commutable]
		static public Vector operator/(Vector a, int b)
		{
			return .(a.X / b, a.Y / b);
		}

		[Inline, Commutable]
		static public Vector operator*(Vector a, float b)
		{
			return .(a.X * b, a.Y * b);
		}

		[Inline]
		static public Vector operator/(Vector a, float b)
		{
			return .(a.X / b, a.Y / b);
		}

		[Inline, Commutable]
		static public Vector operator*(Vector a, Facings f)
		{
			return .(a.X * (int)f, a.Y);
		}

		[Inline]
		static public Vector operator*(Vector a, Mat3x2 b)
		{
			return Transform(a, b);
		}

		[Inline]
		static public Vector operator*(Vector a, Mat4x4 b)
		{
			return Transform(a, b);
		}

		[Inline]
		static public Vector operator-(Vector v)
		{
			return .(-v.X, -v.Y);
		}
	}
}
