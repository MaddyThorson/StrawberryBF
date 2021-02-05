namespace Strawberry.Sample
{
	public class Level : Scene
	{
		public Grid SolidGrid { get; private set; }

		public this()
		{
			Add(new Player(.(50, 50)));
			Add(new OldSolid(.(0, 168), .(0, 0, 320, 12)));
			Add(new OldJumpThru(.(200, 132), 48));
			Add(new MovingJumpThru(.(136, 100), 32, .(124, 140), 2f));
		}
	}
}
