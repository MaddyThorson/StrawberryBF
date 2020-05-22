using System;

namespace Strawberry
{
	public enum Cardinals
	{
		case Right;
		case Down;
		case Left;
		case Up;

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
