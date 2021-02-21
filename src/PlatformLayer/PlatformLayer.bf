using System;
namespace Strawberry
{
	public abstract class PlatformLayer
	{
		public readonly String Title;
		public readonly int ScreenWidth;
		public readonly int ScreenHeight;
		public readonly int WindowScale;

		public Mat4x4 ScreenMatrix { get; private set; }

		public this(String title, int screenWidth, int screenHeight, int windowScale)
		{
			Title = title;
			ScreenWidth = screenWidth;
			ScreenHeight = screenHeight;
			WindowScale = windowScale;
		}

		public void UpdateScreenMatrix()
		{
			ScreenMatrix = Mat4x4.CreateOrthographic(ScreenWidth, ScreenHeight * 0.5f, 0, 1)
				* Mat4x4.CreateScale(.(1, -1, 1))
				* Mat4x4.CreateTranslation(.(-1, 1, 0));
		}

		public abstract bool Closed();			// Returns whether the game window has been closed

		//Rendering
		public abstract void GameRenderBegin();
		public abstract void GameRenderEnd();
		public abstract void ImGuiRenderBegin();
		public abstract void ImGuiRenderEnd();
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
	}
}
