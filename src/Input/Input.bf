using SDL2;
using System;
using System.Diagnostics;

namespace Strawberry
{
	static public class Input
	{
		static private bool* keyboard;
		static private bool[] previousKeyboard;
		static private float[] lastKeypressTimes;
		static private SDL.SDL_GameController*[] gamepads;

		static private void Init(int gamepadLimit)
		{
			keyboard = SDL.GetKeyboardState(null);
			previousKeyboard = new bool[(int)SDL.Scancode.NUMSCANCODES];
			lastKeypressTimes = new float[(int)SDL.Scancode.NUMSCANCODES];

			gamepads = new SDL.SDL_GameController*[gamepadLimit];
			for (let i < gamepads.Count)
				gamepads[i] = SDL.GameControllerOpen((int32)i);
		}

		static private void Dispose()
		{
			delete previousKeyboard;
			delete lastKeypressTimes;
			delete gamepads;
		}

		static public void BeforeUpdate()
		{
			SDL.PumpEvents();
			SDL.GameControllerUpdate();
		}

		static public void AfterUpdate()
		{
			for (let i < previousKeyboard.Count)
			{
				if (!previousKeyboard[i] && keyboard[i])
					lastKeypressTimes[i] = Time.Elapsed;
				previousKeyboard[i] = keyboard[i];
			}
		}

		static public bool Ctrl => SDL.GetModState() & .CTRL > 0;
		static public bool Alt => SDL.GetModState() & .ALT > 0;
		static public bool Shift => SDL.GetModState() & .SHIFT > 0;
		static public bool CapsLock => SDL.GetModState() & .Caps > 0;
		static public bool NumLock => SDL.GetModState() & .Num > 0;

		static public bool KeyCheck(SDL.Scancode key)
		{
			Debug.Assert(keyboard != null, "Polling keyboard before Input.Init");

			return keyboard[(int)key];
		}

		static public bool KeyPressed(SDL.Scancode key)
		{
			Debug.Assert(keyboard != null, "Polling keyboard before Input.Init");

			return keyboard[(int)key] && !previousKeyboard[(int)key];
		}

		static public bool KeyPressed(SDL.Scancode key, float repeatDelay, float repeatInterval)
		{
			Debug.Assert(keyboard != null, "Polling keyboard before Input.Init");

			let i = (int)key;
			if (keyboard[i])
				return !previousKeyboard[i] || Time.OnInterval(repeatInterval, lastKeypressTimes[i] + repeatDelay);
			else
				return false;
		}

		static public bool KeyReleased(SDL.Scancode key)
		{
			Debug.Assert(keyboard != null, "Polling keyboard before Input.Init");

			return !keyboard[(int)key] && previousKeyboard[(int)key];
		}

		static public void KeystrokesIntoString(String toString, float keyRepeatDelay, float keyRepeatInterval)
		{
			KeystrokesIntoStringUtil(toString, scope (k) => Input.KeyPressed(k, keyRepeatDelay, keyRepeatInterval));
		}

		static public void KeystrokesIntoString(String toString)
		{
			KeystrokesIntoStringUtil(toString, scope => Input.KeyPressed);
		}

		static private void KeystrokesIntoStringUtil(String toString, delegate bool(SDL.Scancode) pressed)
		{
			for (let i < (int)SDL2.SDL.Scancode.NUMSCANCODES)
			{
				let key = (SDL2.SDL.Scancode)i;
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

		static public bool GamepadButtonCheck(int gamepadID, SDL.SDL_GameControllerButton button)
		{
			Debug.Assert(gamepads != null, "Polling gamepad before Input.Init");
			Debug.Assert(gamepadID < gamepads.Count, "Gamepad index out of range (increase Game.gamepadLimit!");
			Debug.Assert(gamepadID >= 0, "Negative gamepad index!");

			return SDL.GameControllerGetButton(gamepads[gamepadID], button) == 1;
		}

		static public float GamepadAxisCheck(int gamepadID, SDL.SDL_GameControllerAxis axis)
		{
			Debug.Assert(gamepads != null, "Polling gamepad before Input.Init");
			Debug.Assert(gamepadID < gamepads.Count, "Gamepad index out of range (increase Game.gamepadLimit!");
			Debug.Assert(gamepadID >= 0, "Negative gamepad index!");

			let val = SDL.GameControllerGetAxis(gamepads[gamepadID], axis);
			if (val == 0)
				return 0;
			else if (val > 0)
				return val / 32767f;
			else
				return val / 32768f;
		}
	}
}
