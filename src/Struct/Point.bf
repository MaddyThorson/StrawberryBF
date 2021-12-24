using System;

namespace Strawberry
{
	public struct Point : IHashable
	{
		public const Point Right = .(1, 0);
		public const Point Left = .(-1, 0);
		public const Point Up = .(0, -1);
		public const Point Down = .(0, 1);
		public const Point UnitX = .(1, 0);
		public const Point UnitY = .(0, 1);
		public const Point Zero = .(0, 0);
		public const Point One = .(1, 1);

		public int X;
		public int Y;

		public this()
		{
			this = default;
		}

		public this(int x, int y)
		{
			X = x;
			Y = y;
		}

		public this(JSON json)
			: this(json["x"], json["y"])
		{

		}

		[Inline]
		public Point Perpendicular()
		{
			return .(-Y, X);
		}

		[Inline]
		public float Length => Math.Sqrt(LengthSquared);

		[Inline]
		public int LengthSquared => X * X + Y * Y;

		[Inline]
		public Vector Normalized()
		{
			return ((Vector)this).Normalized();
		}

		[Inline]
		public override void ToString(String strBuffer)
		{
			strBuffer.Set("Point [ ");
			X.ToString(strBuffer);
			strBuffer.Append(", ");
			Y.ToString(strBuffer);
			strBuffer.Append(" ]");
		}

		[Inline]
		static public explicit operator Point(Vector a)
		{
			return .((int)a.X, (int)a.Y);
		}

		[Inline]
		static public implicit operator SDL2.SDL.Point(Point a)
		{
			return .((int32)a.X, (int32)a.Y);
		}

		[Inline, Commutable]
		static public bool operator==(Point a, Point b)
		{
			return a.X == b.X && a.Y == b.Y;
		}

		[Inline]
		static public Point operator+(Point a, Point b)
		{
			return .(a.X + b.X, a.Y + b.Y);
		}

		[Inline]
		static public Point operator-(Point a, Point b)
		{
			return .(a.X - b.X, a.Y - b.Y);
		}

		[Inline, Commutable]
		static public Point operator*(Point a, int b)
		{
			return .(a.X * b, a.Y * b);
		}

		[Inline]
		static public Point operator*(Point a, Point b)
		{
			return .(a.X * b.X, a.Y * b.Y);
		}

		[Inline]
		static public Point operator/(Point a, int b)
		{
			return .(a.X / b, a.Y / b);
		}

		[Inline, Commutable]
		static public Vector operator*(Point a, float b)
		{
			return .(a.X * b, a.Y * b);
		}

		[Inline]
		static public Vector operator/(Point a, float b)
		{
			return .(a.X / b, a.Y / b);
		}

		[Inline]
		static public Point operator/(Point a, Point b)
		{
			return .(a.X / b.X, a.Y / b.Y);
		}

		[Inline, Commutable]
		static public Point operator*(Point a, Facings f)
		{
			return .(a.X * (int)f, a.Y);
		}

		[Inline]
		static public Point operator-(Point p)
		{
			return .(-p.X, -p.Y);
		}

		[Inline]
		public int GetHashCode()
		{
			return X + 9973 * Y;
		}
	}
}
