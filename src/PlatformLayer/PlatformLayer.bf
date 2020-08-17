using System;
namespace Strawberry
{
	public abstract class PlatformLayer
	{
		public abstract void Init();
		public abstract bool Closed();			// Returns whether the game window has been closed

		//Rendering
		public abstract void RenderBegin();
		public abstract void RenderEnd();
		
		//Update
		public abstract uint32 Ticks { get; } 	// Milliseconds since game launched

		//Input
		public abstract void UpdateInput();
		public abstract bool CapsLock { get; }
		public abstract bool NumLock { get; }
		public abstract bool PollKey(Keys key);
		public abstract bool PollGamepadButton(int gamepadID, Buttons button);
		public abstract float PollGamepadAxis(int gamepadID, Axes axis);

		//Graphics
		public abstract Texture LoadTexture(String path);
		public abstract Batcher CreateBatcher();
		public abstract Shader CreateShader(ShaderDef def);
	}
}
