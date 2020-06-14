using SDL2;
using System;

namespace Strawberry
{
	static public class Draw
	{
		static public Point Camera => Game.Scene != null ? Game.Scene.Camera.Round() : Point.Zero;

		static public void Rect(int x, int y, int w, int h, Color color)
		{
			SDL.SetRenderDrawColor(Game.Renderer, color.R, color.G, color.B, color.A);
			SDL.RenderFillRect(Game.Renderer, &SDL.Rect((int32)(x - Camera.X), (int32)(y - Camera.Y), (int32)w, (int32)h));
		}

		static public void Rect(Rect rect, Color color)
		{
			Rect(rect.X, rect.Y, rect.Width, rect.Height, color);
		}

		static public void HollowRect(int x, int y, int w, int h, Color color)
		{
			SDL.SetRenderDrawColor(Game.Renderer, color.R, color.G, color.B, color.A);
			SDL.RenderDrawRect(Game.Renderer, &SDL.Rect((int32)(x - Camera.X), (int32)(y - Camera.Y), (int32)w, (int32)h));
		}

		static public void HollowRect(Rect rect, Color color)
		{
			HollowRect(rect.X, rect.Y, rect.Width, rect.Height, color);
		}

		static public void Line(Point from, Point to, Color color)
		{
			let fromn = (Point)(from - Camera);
			let ton = (Point)(to - Camera);

			SDL.SetRenderDrawColor(Game.Renderer, color.R, color.G, color.B, color.A);
			SDL.RenderDrawLine(Game.Renderer, (int32)fromn.X, (int32)fromn.Y, (int32)ton.X, (int32)ton.Y);
		}

		static public void Circle(Point at, float radius, Color color, int steps = 16)
		{
			let add = at - Camera;

			SDL.Point[] points = scope SDL.Point[steps + 1];
			points[0] = SDL.Point((int32)(radius + add.X), (int32)add.Y);
			points[steps] = points[0];
			float slice = Calc.Circle / steps;

			for (int i = 1; i < steps; i++)
			{
				points[i] = SDL.Point(
					(int32)(Math.Round(Math.Cos(slice * i) * radius) + add.X),
					(int32)(Math.Round(Math.Sin(slice * i) * radius) + add.Y)
				);
			}

			SDL.SetRenderDrawColor(Game.Renderer, color.R, color.G, color.B, color.A);
			SDL.RenderDrawLines(Game.Renderer, &points[0], (int32)steps + 1);
		}

		static public void Sprite(Sprite sprite, int frame, Point position)
		{
			SDL.Rect src = Strawberry.Rect(0, 0, sprite.Width, sprite.Height);
			SDL.Rect dst = Strawberry.Rect(position.X - Camera.X, position.Y - Camera.Y, sprite.Width, sprite.Height);
			SDL.RenderCopy(Game.Renderer, sprite[frame].Texture, &src, &dst);
		}

		static public void Sprite(Sprite sprite, int frame, Point position, Point origin, float rotation)
		{
			SDL.Point cnt = origin;
			SDL.Rect src = Strawberry.Rect(0, 0, sprite.Width, sprite.Height);
			SDL.Rect dst = Strawberry.Rect(position.X - origin.X - Camera.X, position.Y - origin.Y - Camera.Y, sprite.Width, sprite.Height);
			SDL.RenderCopyEx(Game.Renderer, sprite[frame].Texture, &src, &dst, rotation, &cnt, .None);
		}
	}
}
