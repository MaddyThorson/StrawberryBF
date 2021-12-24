namespace Strawberry.Sample
{
	public class Level : Scene
	{
		public Grid SolidGrid { get; private set; }

		public this()
		{
			Add(Player.Create(.(50, 50)));
			Add(MovingJumpThru.Create(.(136, 100), 32, .(124, 140), 2f));
			Add(StaticGeometry.CreateSolid(.(0, 168), .(0, 0, 320, 12)));
			Add(StaticGeometry.CreateJumpThru(.(200, 132), 48));
		}
	}
}
