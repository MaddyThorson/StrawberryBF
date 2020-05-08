using System;

namespace Strawberry
{
	public struct Rect
	{
		public int X;
		public int Y;
		public int Width;
		public int Height;

		public this()
		{
			this = default;
		}

		public this(int x, int y, int width, int height)
		{
			X = x;
			Y = y;
			Width = width;
			Height = height;
		}

		public int Left
		{
			[Inline]
			get
			{
				return X;
			}

			[Inline]
			set	mut
			{
				X = value;
			}
		}

		public int Right
		{
			[Inline]
			get
			{
				return X + Width;
			}

			[Inline]
			set	mut
			{
				X = value - Width;
			}
		}

		public int Top
		{
			[Inline]
			get
			{
				return Y;
			}

			[Inline]
			set mut
			{
				Y = value;
			}
		}

		public int Bottom
		{
			[Inline]
			get
			{
				return Y + Height;
			}

			[Inline]
			set mut
			{
				Y = value - Height;
			}
		}

		public Rect MirrorX(int axis = 0)
		{
			var rect = this;
			rect.X = axis - X - Width;
			return rect;
		}

		public Rect MirrorY(int axis = 0)
		{
			var rect = this;
			rect.Y = axis - Y - Height;
			return rect;
		}

		public Rect Inflate(int amount)
		{
			return Rect(X - amount, Y - amount, Width + amount * 2, Height + amount * 2);
		}

		public bool Intersects(Rect rect)
		{
			return (X + Width) > rect.X	&& (rect.X + rect.Width) > X && (Y + Height) > rect.Y && (rect.Y + rect.Height) > Y;
		}

		public bool Contains(Point point)
		{
			return point.X >= X && point.X < X + Width && point.Y >= Y && point.Y < Y + Height;
		}

		public override void ToString(String strBuffer)
		{
			strBuffer.Set("Rect [ ");
			X.ToString(strBuffer);
			strBuffer.Append(", ");
			Y.ToString(strBuffer);
			strBuffer.Append(", ");
			Width.ToString(strBuffer);
			strBuffer.Append(", ");
			Height.ToString(strBuffer);
			strBuffer.Append(" ]");
		}

		static public bool operator==(Rect a, Rect b)
		{
			return a.X == b.X && a.Y == b.Y && a.Width == b.Width && a.Height == b.Height;
		}

		static public Rect operator+(Rect a, Point b)
		{
			return Rect(a.X + b.X, a.Y + b.Y, a.Width, a.Height);
		}

		static public Rect operator-(Rect a, Point b)
		{
			return Rect(a.X - b.X, a.Y - b.Y, a.Width, a.Height);
		}
	}
}
