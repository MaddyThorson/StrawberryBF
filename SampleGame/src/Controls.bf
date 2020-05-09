namespace Strawberry.Sample
{
	static public class Controls
	{
		static public VirtualAxis MoveX;
		static public VirtualButton Jump;

		static public void Init()
		{
			Jump = new VirtualButton()
				.AddKey(.Space)
				.AddKey(.X)
				.AddButton(0, .A)
				.PressBuffer(0.1f);

			MoveX = new VirtualAxis()
				.AddKeys(.Left, .Right, .TakeNewer)
				.AddButtons(0, .DpadLeft, .DpadRight, .TakeNewer)
				.AddAxis(0, .LeftX, 0.3f);
		}
	}
}
