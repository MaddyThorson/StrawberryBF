namespace Strawberry
{
	static public class Console
	{
		static public bool Enabled;

		static public void Update()
		{
			if (Input.KeyPressed(.Grave))
				Enabled = !Enabled;
		}

		static public void Draw()
		{
			Calc.Log();
			Draw.Rect(0, 0, Game.Width, Game.Height, .Black * 0.4f);
		}
	}
}
