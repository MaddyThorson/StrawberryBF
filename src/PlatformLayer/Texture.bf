namespace Strawberry
{
	public class Texture
	{
		public uint32 Handle { get; private set; }
		public int Width { get; private set; }
		public int Height { get; private set; }

		public this(int width, int height, uint8* pixels)
		{
			Width = width;
			Height = height;

			GL.glGenTextures(1, &Handle);
			GL.glBindTexture(GL.GL_TEXTURE_2D, Handle);
			GL.glTexImage2D(GL.GL_TEXTURE_2D, 0, GL.GL_RGBA, width, height, 0, GL.GL_RGBA, GL.GL_UNSIGNED_BYTE, pixels);
		}

		public ~this()
		{
			GL.glDeleteTextures(1, &Handle);
		}
	}
}
