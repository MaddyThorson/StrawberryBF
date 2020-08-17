namespace Strawberry.SDL2
{
	class SDL2Texture : Texture
	{
		private uint32 handle;

		public this(int width, int height, uint8* pixels)
			: base(width, height, pixels)
		{
			GL.glGenTextures(1, &handle);
			GL.glBindTexture(GL.GL_TEXTURE_2D, handle);
			GL.glTexImage2D(GL.GL_TEXTURE_2D, 0, GL.GL_RGBA, width, height, 0, GL.GL_RGBA, GL.GL_UNSIGNED_BYTE, pixels);
		}

		public ~this()
		{
			GL.glDeleteTextures(1, &handle);
		}
	}
}
