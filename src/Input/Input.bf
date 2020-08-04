using System;
using System.Diagnostics;

namespace Strawberry
{
	static public class Input
	{
		
		static private bool[] previousKeyboard;
		static private float[] lastKeypressTimes;
		
		static private void Init()
		{
			previousKeyboard = new bool[Keys.Count];
			lastKeypressTimes = new float[Keys.Count];
		}

		static private void Dispose()
		{
			delete previousKeyboard;
			delete lastKeypressTimes;
		}

		static public void AfterUpdate()
		{
			for (let i < previousKeyboard.Count)
			{
				if (!previousKeyboard[i] && Game.PlatformLayer.PollKey((Keys)i))
					lastKeypressTimes[i] = Time.Elapsed;
				previousKeyboard[i] = Game.PlatformLayer.PollKey((Keys)i);
			}
		}

		static public bool Ctrl => KeyCheck(Keys.LCtrl) || KeyCheck(Keys.RCtrl);
		static public bool Alt => KeyCheck(Keys.LCtrl) || KeyCheck(Keys.RCtrl);
		static public bool Shift => KeyCheck(Keys.LCtrl) || KeyCheck(Keys.RCtrl);
		static public bool CapsLock => Game.PlatformLayer.CapsLock;
		static public bool NumLock => Game.PlatformLayer.NumLock;

		static public bool KeyCheck(Keys key)
		{
			return Game.PlatformLayer.PollKey(key);
		}

		static public bool KeyPressed(Keys key)
		{
			return Game.PlatformLayer.PollKey(key) && !previousKeyboard[(int)key];
		}

		static public bool KeyPressed(Keys key, float repeatDelay, float repeatInterval)
		{
			if (Game.PlatformLayer.PollKey(key))
				return !previousKeyboard[(int)key] || Time.OnInterval(repeatInterval, lastKeypressTimes[(int)key] + repeatDelay);
			else
				return false;
		}

		static public bool KeyReleased(Keys key)
		{
			return !Game.PlatformLayer.PollKey(key) && previousKeyboard[(int)key];
		}

		static public void KeystrokesIntoString(String toString, float keyRepeatDelay, float keyRepeatInterval)
		{
			KeystrokesIntoStringUtil(toString, scope (k) => Input.KeyPressed(k, keyRepeatDelay, keyRepeatInterval));
		}

		static public void KeystrokesIntoString(String toString)
		{
			KeystrokesIntoStringUtil(toString, scope => Input.KeyPressed);
		}

		static private void KeystrokesIntoStringUtil(String toString, delegate bool(Keys) pressed)
		{
			for (let i < (int)Keys.Count)
			{
				let key = (Keys)i;
				if (pressed(key))
				{
					if (key >= .A && key <= .Z)
					{
						char8 c;
						if (Input.Shift || Input.CapsLock)
							c = 'A' + (int)(key - .A);
						else
							c = 'a' + (int)(key - .A);
						toString.Append(c);
					}
					else if (key >= .Key1 && key <= .Key9 && !Input.Shift)
					{
						char8 c = '1' + (int)(key - .Key1);
						toString.Append(c);
					}
					else
					{
						switch (key)
						{
						case .Key1 when Input.Shift:
							toString.Append('!');
						case .Key2 when Input.Shift:
							toString.Append('@');
						case .Key3 when Input.Shift:
							toString.Append('#');
						case .Key4 when Input.Shift:
							toString.Append('$');
						case .Key5 when Input.Shift:
							toString.Append('%');
						case .Key6 when Input.Shift:
							toString.Append('^');
						case .Key7 when Input.Shift:
							toString.Append('&');
						case .Key8 when Input.Shift:
							toString.Append('*');
						case .Key9 when Input.Shift:
							toString.Append('(');
						case .Key0 when Input.Shift:
							toString.Append(')');
						case .Key0:
							toString.Append('0');
						case .Space:
							toString.Append(' ');
						case .Minus when Input.Shift:
							toString.Append('_');
						case .Minus:
							toString.Append('-');
						case .Equals when Input.Shift:
							toString.Append('+');
						case .Equals:
							toString.Append('=');
						case .LeftBracket when Input.Shift:
							toString.Append('{');
						case .LeftBracket:
							toString.Append('[');
						case .RightBracket when Input.Shift:
							toString.Append('}');
						case .RightBracket:
							toString.Append(']');
						case .BackSlash when Input.Shift:
							toString.Append('|');
						case .BackSlash:
							toString.Append('\\');
						case .Semicolon when Input.Shift:
							toString.Append(':');
						case .Semicolon:
							toString.Append(';');
						case .Apostrophe when Input.Shift:
							toString.Append('"');
						case .Apostrophe:
							toString.Append('\'');
						case .Comma when Input.Shift:
							toString.Append('<');
						case .Comma:
							toString.Append(',');
						case .Period when Input.Shift:
							toString.Append('>');
						case .Period:
							toString.Append('.');
						case .Slash when Input.Shift:
							toString.Append('?');
						case .Slash:
							toString.Append('/');
						case .BackSpace:
							if (toString.Length > 0)
								toString.RemoveFromEnd(1);
						default:
						}
					}
				}
			}
		}

		static public bool GamepadButtonCheck(int gamepadID, Buttons button)
		{
			return Game.PlatformLayer.PollGamepadButton(gamepadID, button);
		}

		static public float GamepadAxisCheck(int gamepadID, Axes axis)
		{
			return Game.PlatformLayer.PollGamepadAxis(gamepadID, axis);
		}
	}
}
