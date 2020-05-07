using System.Collections;
using System;
using System.Diagnostics;
using SDL2;

namespace Strawberry
{
	public class VirtualButton : VirtualInput
	{
		public bool Check { get; private set; }
		public bool Pressed { get; private set; }
		public bool Released { get; private set; }
		public bool Repeating { get; private set; }

		private List<Node> nodes;
		private float pressBuffer;
		private float releaseBuffer;
		private float repeatStart;
		private float repeatInterval;

		private float lastPress;
		private float lastRelease;
		private float lastPressClear;
		private float lastReleaseClear;

		public this()
		{
			nodes = new List<Node>();
		}

		public ~this()
		{
			for (var n in nodes)
				delete n;
			delete nodes;
		}

		override public void Update()
		{
			//Check
			let last = Check;
			Check = false;
			for (var n in nodes)
			{
				if (n.Check)
				{
					Check = true;
					break;
				}
			}

			//Press
			if (!last && Check)
				lastPress = Time.Elapsed;
			Pressed = Check && lastPress > lastPressClear && Time.Elapsed - lastPress <= pressBuffer;

			//Repeat
			if (Check && repeatStart > 0 && Time.Elapsed - lastPress >= repeatStart)
			{
				Repeating = true;

				int a = (int)((Time.PreviousElapsed - lastPress) / repeatInterval);
				int b = (int)((Time.Elapsed - lastPress) / repeatInterval);
				if (a != b)
					Pressed = true;
			}
			else
				Repeating = false;

			//Release
			if (last && !Check)
				lastRelease = Time.Elapsed;
			Released = !Check && lastRelease > lastReleaseClear && Time.Elapsed - lastRelease <= releaseBuffer;
		}

		public void ClearPressBuffer()
		{
			lastPressClear = Time.Elapsed;
		}

		public void ClearReleaseBuffer()
		{
			lastReleaseClear = Time.Elapsed;
		}

		// Setup Calls

		public VirtualButton Key(SDL.Scancode keycode)
		{
			nodes.Add(new KeyboardKey(keycode));
			return this;
		}

		public VirtualButton Button(SDL.SDL_GameControllerButton button)
		{
			nodes.Add(new GamepadButton(button));
			return this;
		}

		public VirtualButton PressBuffer(float time)
		{
			pressBuffer = time;
			return this;
		}

		public VirtualButton ReleaseBuffer(float time)
		{
			releaseBuffer = time;
			return this;
		}

		public VirtualButton Repeat(float start, float interval)
		{
			repeatStart = start;
			repeatInterval = interval;
			return this;
		}

		// Nodes

		private abstract class Node
		{
			public abstract bool Check { get; }
		}

		private class KeyboardKey : Node
 		{
			public SDL.Scancode Keycode;

			public this(SDL.Scancode keycode)
			{
				Keycode = keycode;
			}

			override public bool Check
			{
				get
				{
					 return Game.KeyCheck(Keycode);
				}
			}
		}

		private class GamepadButton : Node
		{
			public SDL.SDL_GameControllerButton Button;

			public this(SDL.SDL_GameControllerButton button)
			{
				Button = button;
			}

			override public bool Check
			{
				get
				{
					 return Game.GamepadButtonCheck(Button);
				}
			}
		}

		private class GamepadAxis : Node
		{
			public SDL.SDL_GameControllerAxis Axis;
			public float Threshold;
			public ThresholdConditions Condition;

			public this(SDL.SDL_GameControllerAxis axis, float threshold, ThresholdConditions condition = .GreaterThan)
			{
				Axis = axis;
				Threshold = threshold;
				Condition = condition;
			}

			override public bool Check
			{
				get
				{
					if (Condition == .GreaterThan)
					 	return Game.GamepadAxisCheck(Axis) >= Threshold;
					else
						return Game.GamepadAxisCheck(Axis) <= Threshold;
				}
			}
		}
	}
}
