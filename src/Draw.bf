namespace Strawberry
{
	static public class Draw
	{
		static public void Rect(int x, int y, int w, int h, SDL2.SDL.Color color)
		{
			SDL2.SDL.SetRenderDrawColor(Game.mRenderer, color.r, color.g, color.b, color.a);
			SDL2.SDL.RenderFillRect(Game.mRenderer, &SDL2.SDL.Rect((int32)x, (int32)y, (int32)w, (int32)h));
		}

		static public void Rect(Rect rect, SDL2.SDL.Color color)
		{
			Rect(rect.X, rect.Y, rect.Width, rect.Height, color);
		}
	}
}
