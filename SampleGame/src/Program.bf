using System;

namespace Strawberry.Sample
{
	static public class Program
	{
		static public int Main(String[] args)
		{
			let game = scope SampleGame();
			game.Run();
			return 0;
		}
	}
}
