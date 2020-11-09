namespace Strawberry
{
	public class Texture
	{
		public uint32 Handle { get; private set; }
		public int Width { get; private set; }
		public int Height { get; private set; }

		private static int32 OGLMajorV = -1;

		public this(int width, int height, uint8* pixels, bool indLinear, bool indClamp)
		{
			Width = width;
			Height = height;

			if (OGLMajorV == -1)
				GL.glGetIntegerv(GL.GL_MAJOR_VERSION, &OGLMajorV);

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

			if (OGLMajorV < 3) // OpenGL > 1.4 && < 3.0
				GL.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_GENERATE_MIPMAP, GL.GL_TRUE);

			GL.glTexImage2D(GL.GL_TEXTURE_2D, 0, GL.GL_RGBA, width, height, 0, GL.GL_RGBA, GL.GL_UNSIGNED_BYTE, pixels);

			if (OGLMajorV >= 3) // OpenGL >= 3.0
				GL.glGenerateMipmap(GL.GL_TEXTURE_2D);

			// Clear state
			GL.glBindTexture(GL.GL_TEXTURE_2D, 0);
		}

		public ~this()
		{
			GL.glDeleteTextures(1, &Handle);
		}
	}
}
