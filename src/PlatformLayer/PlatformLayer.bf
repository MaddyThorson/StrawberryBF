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
	}

	public abstract class Texture
	{
		public int Width { get; private set; }
		public int Height { get; private set; }

		public virtual this(int width, int height, uint8* pixels)
		{
			Width = width;
			Height = height;
		}
	}

	public abstract class Shader
	{
		public bool IsValid { get; protected set; }

		public this(ShaderDef def)
		{

		}
	}

	public struct ShaderDef
	{
		public String Vertex;
		public String Fragment;

		public this(String vertex, String fragment)
		{
			Vertex = vertex;
			Fragment = fragment;
		}

		public this(String[2] str)
		{
			Vertex = str[0];
			Fragment = str[1];
		}

		static implicit public operator ShaderDef(String[2] str)
		{
			return ShaderDef(str);
		}
	}
}
