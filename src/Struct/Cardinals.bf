using System;

namespace Strawberry
{
	public enum Cardinals
	{
		case Right;
		case Down;
		case Left;
		case Up;

		public int X
		{
			get
			{
				switch (this)
				{
				case .Left:
					return -1;
				case .Right:
					return 1;
				case .Up:
				case .Down:
				default:
				}

				return 0;
			}
		}

		public int Y
		{
			get
			{
				switch (this)
				{
				case .Up:
					return -1;
				case .Down:
					return 1;
				case .Left:
				case .Right:
				default:
				}

				return 0;
			}
		}

		public Cardinals Opposite()
		{
			switch (this)
			{
			case .Right:
				return .Left;
			case .Left:
				return .Right;
			case .Up:
				return .Down;
			case .Down:
				return .Up;
			}
		}

		public Cardinals NextClockwise()
		{
			switch (this)
			{
			case .Right:
				return .Down;
			case .Left:
				return .Up;
			case .Up:
				return .Right;
			case .Down:
				return .Left;
			}
		}

		public Cardinals NextCounterClockwise()
		{
			switch (this)
			{
			case .Right:
				return .Up;
			case .Left:
				return .Down;
			case .Up:
				return .Left;
			case .Down:
				return .Right;
			}
		}

		static public Cardinals operator -(Cardinals c)
		{
			return c.Opposite();
		}

		static public implicit operator Cardinals(Facings f)
		{
			if (f == Facings.Right)
				return Cardinals.Right;
			else
				return Cardinals.Left;
		}

		static public implicit operator Point(Cardinals c)
		{
			switch (c)
			{
			case .Right:
				return Point.Right;
			case .Left:
				return Point.Left;
			case .Up:
				return Point.Up;
			case .Down:
				return Point.Down;
			}
		}

		static public implicit operator Vector(Cardinals c)
		{
			switch (c)
			{
			case .Right:
				return Vector.Right;
			case .Left:
				return Vector.Left;
			case .Up:
				return Vector.Up;
			case .Down:
				return Vector.Down;
			}
		}

		static public Result<Cardinals> FromPoint(Point p)
		{
			if (p.X > 0 && p.Y == 0)
				return .Right;
			else if (p.X < 0 && p.Y == 0)
				return .Left;
			else if (p.Y < 0 && p.X == 0)
				return .Up;
			else if (p.Y > 0 && p.X == 0)
				return .Down;
			else
				return .Err;
		}

		static public Result<Cardinals> FromVector(Vector v)
		{
			if (v.X > 0 && v.Y == 0)
				return .Right;
			else if (v.X < 0 && v.Y == 0)
				return .Left;
			else if (v.Y < 0 && v.X == 0)
				return .Up;
			else if (v.Y > 0 && v.X == 0)
				return .Down;
			else
				return .Err;
		}
	}
}
