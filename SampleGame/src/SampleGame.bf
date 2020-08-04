using System;

namespace Strawberry.Sample
{
	public class SampleGame : Game
	{
		public this(PlatformLayer platformLayer)
			: base(platformLayer, "Strawberry Sample Game!", 320, 180, 3)
		{
			Controls.Init();
			Scene = new Level();
		}
	}
}
