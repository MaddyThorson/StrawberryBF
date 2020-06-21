namespace Strawberry
{
	public enum Facings
	{
		case Right = 1;
		case Left = -1;

		public Facings Opposite()
		{
			if (this == .Right)
				return .Left;
			else
				return .Right;
		}

		static public Facings FromInt(int i, Facings ifZero = .Right)
		{
			if (i == 0)
				return ifZero;
			else
				return i;
		}

		static public implicit operator Facings(int i)
		{
			if (i < 0)
				return .Left;
			else
				return .Right;
		}

		static public implicit operator Point(Facings f)
		{
			return .((int)f, 0);
		}
	}
}
