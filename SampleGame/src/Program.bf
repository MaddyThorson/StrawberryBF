using System;
using Strawberry.SDL2;

namespace Strawberry.Sample
{
	static public class Program
	{
		static public int Main(String[] args)
		{
			let sdl = scope SDL2PlatformLayer("Strawberry Sample Game!", 320, 180, 3);
			sdl.TextureClamping = true;
			PlatformLayer = sdl;

			Engine.Run(scope SampleGame());

			return 0;
		}
	}
}
