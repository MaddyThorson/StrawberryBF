using System;

namespace Strawberry
{
	public struct Point
	{
		static public readonly Point Right = .(1, 0);
		static public readonly Point Left = .(-1, 0);
		static public readonly Point Up = .(0, -1);
		static public readonly Point Down = .(0, 1);
		static public readonly Point UnitX = .(1, 0);
		static public readonly Point UnitY = .(0, 1);
		static public readonly Point Zero = .(0, 0);
		static public readonly Point One = .(1, 1);

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

		public Point Perpendicular()
		{
			return .(-Y, X);
		}

		public float Length => Math.Sqrt(LengthSquared);
		public int LengthSquared => X * X + Y * Y;

		public override void ToString(String strBuffer)
		{
			strBuffer.Set("Point [ ");
			X.ToString(strBuffer);
			strBuffer.Append(", ");
			Y.ToString(strBuffer);
			strBuffer.Append(" ]");
		}

		static public explicit operator Point(Vector a)
		{
			return Point((int)a.X, (int)a.Y);
		}

		static public implicit operator SDL2.SDL.Point(Point a)
		{
			return .((int32)a.X, (int32)a.Y);
		}

		static public bool operator==(Point a, Point b)
		{
			return a.X == b.X && a.Y == b.Y;
		}

		static public Point operator+(Point a, Point b)
		{
			return Point(a.X + b.X, a.Y + b.Y);
		}

		static public Point operator-(Point a, Point b)
		{
			return Point(a.X - b.X, a.Y - b.Y);
		}

		static public Point operator*(Point a, int b)
		{
			return Point(a.X * b, a.Y * b);
		}

		static public Point operator*(Point a, Point b)
		{
			return Point(a.X * b.X, a.Y * b.Y);
		}

		static public Point operator/(Point a, int b)
		{
			return Point(a.X / b, a.Y / b);
		}

		static public Point operator/(Point a, Point b)
		{
			return Point(a.X / b.X, a.Y / b.Y);
		}
	}
}
