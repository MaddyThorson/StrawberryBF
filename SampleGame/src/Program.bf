using System;
using Strawberry.SDL2;

namespace Strawberry.Sample
{
	static public class Program
	{
		static public int Main(String[] args)
		{
			let sdl = scope SDL2PlatformLayer();
			sdl.TexturesEnableEdgeClamping = true;
			let game = scope SampleGame(sdl);

			game.Run();
			return 0;
		}
	}
}
