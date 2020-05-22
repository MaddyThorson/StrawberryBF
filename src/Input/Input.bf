using SDL2;
using System;
using System.Diagnostics;

namespace Strawberry
{
	static public class Input
	{
		static private bool* keyboard;
		static private bool[] previousKeyboard;
		static private SDL.SDL_GameController*[] gamepads;

		static private void Init(int gamepadLimit)
		{
			keyboard = SDL.GetKeyboardState(null);
			previousKeyboard = new bool[(int)SDL.Scancode.NUMSCANCODES];

			gamepads = new SDL.SDL_GameController*[gamepadLimit];
			for (let i < gamepads.Count)
				gamepads[i] = SDL.GameControllerOpen((int32)i);
		}

		static private void Dispose()
		{
			delete previousKeyboard;
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
				previousKeyboard[i] = keyboard[i];
		}

		static public bool KeyCheck(SDL.Scancode key)
		{
			if (keyboard == null)
				Debug.FatalError("Polling keyboard before Input.Init");

			return keyboard[(int)key];
		}

		static public bool KeyPressed(SDL.Scancode key)
		{
			if (keyboard == null)
				Debug.FatalError("Polling keyboard before Input.Init");

			return keyboard[(int)key] && !previousKeyboard[(int)key];
		}

		static public bool KeyReleased(SDL.Scancode key)
		{
			if (keyboard == null)
				Debug.FatalError("Polling keyboard before Input.Init");

			return !keyboard[(int)key] && previousKeyboard[(int)key];
		}

		static public bool GamepadButtonCheck(int gamepadID, SDL.SDL_GameControllerButton button)
		{
			if (gamepads == null)
				Debug.FatalError("Polling gamepad before Input.Init");
			if (gamepadID >= gamepads.Count)
				Debug.FatalError("Gamepad index out of range (increase Game.gamepadLimit!");

			return SDL.GameControllerGetButton(gamepads[gamepadID], button) == 1;
		}

		static public float GamepadAxisCheck(int gamepadID, SDL.SDL_GameControllerAxis axis)
		{
			if (gamepads == null)
				Debug.FatalError("Polling gamepad before Input.Init");
			if (gamepadID >= gamepads.Count)
				Debug.FatalError("Gamepad index out of range (increase Game.gamepadLimit!");

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
