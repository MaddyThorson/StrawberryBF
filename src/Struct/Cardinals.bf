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
	}
}
