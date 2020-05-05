using System;

namespace Strawberry
{
	public struct Point
	{
		static public readonly Point Right = Point(1, 0);
		static public readonly Point Left = Point(-1, 0);
		static public readonly Point Up = Point(0, -1);
		static public readonly Point Down = Point(0, 1);
		static public readonly Point Zero = Point(0, 0);
		static public readonly Point One = Point(1, 1);

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

		static public explicit operator Point(Vector a)
		{
			return Point((int)a.X, (int)a.Y);
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

		static public Point operator/(Point a, int b)
		{
			return Point(a.X / b, a.Y / b);
		}
	}
}
