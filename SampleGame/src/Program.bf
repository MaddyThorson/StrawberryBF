using System;

namespace Strawberry.Sample
{
	static public class Program
	{
		static public int Main(String[] args)
		{
			SDL2PlatformLayer sdl = scope SDL2PlatformLayer();
			let game = scope SampleGame(sdl);
			game.Run();
			return 0;
		}
	}
}
