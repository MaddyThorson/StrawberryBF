namespace Strawberry
{
	enum Axes : int32
	{
		case Invalid = -1;
		case LeftX;
		case LeftY;
		case RightX;
		case RightY;
		case TriggerLeft;
		case TriggerRight;

		public int Count => (int)TriggerRight + 1;
	}
}
