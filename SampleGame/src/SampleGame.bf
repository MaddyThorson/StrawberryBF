using System;

namespace Strawberry.Sample
{
	public class SampleGame : Game
	{
		protected override void Started()
		{
			Controls.Init();
			Scene = new Level();
		}
	}
}
