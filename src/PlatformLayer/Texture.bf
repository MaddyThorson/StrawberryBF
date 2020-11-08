namespace Strawberry
{
	public class Texture
	{
		public uint32 Handle { get; private set; }
		public int Width { get; private set; }
		public int Height { get; private set; }

		public this(int width, int height, uint8* pixels, bool indLinear, bool indClamp)
		{
			Width = width;
			Height = height;

			GL.glGenTextures(1, &Handle);
			GL.glBindTexture(GL.GL_TEXTURE_2D, Handle);

			// (OPTIONAL) Set linear Mipmaps
			if (indLinear) {
				GL.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_MAG_FILTER, GL.GL_LINEAR);
				GL.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_MIN_FILTER, GL.GL_LINEAR_MIPMAP_LINEAR);
			}
			
			// (OPTIONAL) Apply edge clamping
			if (indClamp) {
				GL.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_WRAP_S, GL.GL_CLAMP_TO_EDGE);
				GL.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_WRAP_T, GL.GL_CLAMP_TO_EDGE);
			}

			GL.glTexImage2D(GL.GL_TEXTURE_2D, 0, GL.GL_RGBA, width, height, 0, GL.GL_RGBA, GL.GL_UNSIGNED_BYTE, pixels);

			GL.glGenerateMipmap(GL.GL_TEXTURE_2D); // Unavailable in OpenGL 2.1.

			// Clear state
			GL.glBindTexture(GL.GL_TEXTURE_2D, 0);
		}

		public ~this()
		{
			GL.glDeleteTextures(1, &Handle);
		}
	}
}
