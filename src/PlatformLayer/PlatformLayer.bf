using System;
namespace Strawberry
{
	public abstract class PlatformLayer
	{
		public abstract void Init();
		public abstract void RenderBegin();
		public abstract void RenderEnd();
		public abstract void UpdateInput();

		public abstract bool PollKey(Keys key);
		public abstract bool CapsLock { get; }
		public abstract bool NumLock { get; }
		public abstract bool PollGamepadButton(int gamepadID, Buttons button);
		public abstract float PollGamepadAxis(int gamepadID, Axes axis);

		// Returns milliseconds since last tick
		public abstract uint32 Tick();

		// If the game window has been closed
		public abstract bool Closed();
	}
}
