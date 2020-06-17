using System;

namespace Strawberry
{
	static public class Console
	{
		static public bool Open;

		static private bool enabled;
		static private SDL2.SDLTTF.Font* font;
		static private String entry;

		static public void Init()
		{
			enabled = true;
			font = SDL2.SDLTTF.OpenFont("../../../../Strawberry/src/Content/strawberry-seeds.ttf", 8);
			entry = new String();
		}

		static public void Dispose()
		{
			SDL2.SDLTTF.CloseFont(font);
			delete entry;
		}

		static public bool Enabled
		{
			get => enabled;
			set
			{
				enabled = value;
				if (!enabled)
					Open = false;
			}
		}

		static public void Update()
		{
			if (enabled)
			{
				if (Input.KeyPressed(.Grave))
					Open = !Open;
	
				if (Open)
				{
					Input.KeystrokesIntoString(entry, 0.25f, 0.05f);
					if (Input.KeyPressed(.Delete))
						entry.Clear();
				}
			}
		}

		static public void Draw()
		{
			if (enabled && Open)
			{
				Draw.Rect(0, 0, Game.Width, Game.Height, .Black * 0.6f);
				Draw.Rect(0, Game.Height - 12, Game.Width, 14, .Black * 0.6f);

				Text(">", 0, 0, .White);
				if (entry.Length > 0)
					Text(entry, 0, 1, .White);
				if (Time.BetweenInterval(0.3f))
					Text("_", 0, entry.Length + 1, .White);
			}
		}

		static private void Text(String str, int row, int col, Color color)
		{
			Point pos = .(4 + 6 * col, Game.Height - 10 - 10 * row);
			if (row > 0)
				pos.Y -= 4;

			Draw.Text(font, str, pos + .Down, .Black);
			Draw.Text(font, str, pos, color);
		}	
	}
}
