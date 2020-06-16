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

		static public bool Ctrl => KeyCheck(.LCtrl) || KeyCheck(.RCtrl);
		static public bool Alt => KeyCheck(.LAlt) || KeyCheck(.RAlt);
		static public bool Shift => KeyCheck(.LShift) || KeyCheck(.RShift);

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
