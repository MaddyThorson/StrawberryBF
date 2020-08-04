namespace Strawberry
{
	enum Buttons : int32
	{
		case Invalid = -1;
		case A;
		case B;
		case X;
		case Y;
		case Back;
		case Guide;
		case Start;
		case LeftStick;
		case RightStick;
		case LeftShoulder;
		case RightShoulder;
		case DpadUp;
		case DpadDown;
		case DpadLeft;
		case DpadRight;

		public int Count => (int)DpadRight + 1;
	}
}
