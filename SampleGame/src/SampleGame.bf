using System;

namespace Strawberry.Sample
{
	public class SampleGame : Game
	{
		public this()
			: base("Strawberry Sample Game!", 320, 180, 3)
		{
			Controls.Init();
			Scene = new Level();
		}
	}
}
