using SDL2;

namespace Strawberry
{
	static public class Input
	{
		static public bool KeyCheck(SDL.Scancode key)
		{
			if (Game.KeyboardState == null)
				return false;
			return Game.KeyboardState[(int)key];
		}

		static public bool KeyPressed(SDL.Scancode key)
		{
			return KeyCheck(key) && (Game.PreviousKeyboardState == null || !Game.PreviousKeyboardState[(int)key]);
		}

		static public bool KeyReleased(SDL.Scancode key)
		{
			return (Game.PreviousKeyboardState != null && Game.PreviousKeyboardState[(int)key]) && !KeyCheck(key);
		}
	}
}
