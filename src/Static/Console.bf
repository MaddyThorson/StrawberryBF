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
					RegisterKeypresses();
			}
		}

		static private void RegisterKeypresses()
		{
			for (let i < (int)SDL2.SDL.Scancode.NUMSCANCODES)
			{
				let key = (SDL2.SDL.Scancode)i;
				if (Input.KeyPressed(key, 0.25f, 0.05f))
				{
					if (key >= .A && key <= .Z)
					{
						char8 c;
						if (Input.Shift || Input.CapsLock)
							c = 'A' + (int)(key - .A);
						else
							c = 'a' + (int)(key - .A);
						entry.Append(c);
					}
					else if (key >= .Key1 && key <= .Key9 && !Input.Shift)
					{
						char8 c = '1' + (int)(key - .Key1);
						entry.Append(c);
					}
					else
					{
						switch (key)
						{
						case .Key1 when Input.Shift:
							entry.Append('!');
						case .Key2 when Input.Shift:
							entry.Append('@');
						case .Key3 when Input.Shift:
							entry.Append('#');
						case .Key4 when Input.Shift:
							entry.Append('$');
						case .Key5 when Input.Shift:
							entry.Append('%');
						case .Key6 when Input.Shift:
							entry.Append('^');
						case .Key7 when Input.Shift:
							entry.Append('&');
						case .Key8 when Input.Shift:
							entry.Append('*');
						case .Key9 when Input.Shift:
							entry.Append('(');
						case .Key0 when Input.Shift:
							entry.Append(')');
						case .Key0:
							entry.Append('0');
						case .Space:
							entry.Append(' ');
						case .Minus when Input.Shift:
							entry.Append('_');
						case .Minus:
							entry.Append('-');
						case .Equals when Input.Shift:
							entry.Append('+');
						case .Equals:
							entry.Append('=');
						case .LeftBracket when Input.Shift:
							entry.Append('{');
						case .LeftBracket:
							entry.Append('[');
						case .RightBracket when Input.Shift:
							entry.Append('}');
						case .RightBracket:
							entry.Append(']');
						case .BackSlash when Input.Shift:
							entry.Append('|');
						case .BackSlash:
							entry.Append('\\');
						case .Semicolon when Input.Shift:
							entry.Append(':');
						case .Semicolon:
							entry.Append(';');
						case .Apostrophe when Input.Shift:
							entry.Append('"');
						case .Apostrophe:
							entry.Append('\'');
						case .Comma when Input.Shift:
							entry.Append('<');
						case .Comma:
							entry.Append(',');
						case .Period when Input.Shift:
							entry.Append('>');
						case .Period:
							entry.Append('.');
						case .Slash when Input.Shift:
							entry.Append('?');
						case .Slash:
							entry.Append('/');

						case .BackSpace:
							if (entry.Length > 0)
								entry.RemoveFromEnd(1);
						case .Delete:
							entry.Clear();

						default:
						}
					}
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
