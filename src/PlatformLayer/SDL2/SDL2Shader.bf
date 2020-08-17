namespace Strawberry.SDL2
{
	class SDL2Shader : Shader
	{
		public uint vertexHandle;
		public uint fragmentHandle;

		public this(ShaderDef def)
			: base(def)
		{
			IsValid = true;
			int32 logLen = 0;
			char8[1024] log;

			vertexHandle = GL.glCreateShader(GL.GL_VERTEX_SHADER);
			{
				int32 len = (int32)def.Vertex.Length;
				char8* data = def.Vertex.CStr();
				GL.glShaderSource(vertexHandle, 1, &data, &len);
				GL.glCompileShader(vertexHandle);
				GL.glGetShaderInfoLog(vertexHandle, 1024, &logLen, &log);

				if (logLen > 0)
				{
					Calc.Log(&log, logLen);
					IsValid = false;
				}
			}

			fragmentHandle = GL.glCreateShader(GL.GL_FRAGMENT_SHADER);
			{
				int32 len = (int32)def.Fragment.Length;
				char8* data = def.Fragment.CStr();
				GL.glShaderSource(fragmentHandle, 1, &data, &len);
				GL.glCompileShader(fragmentHandle);
				GL.glGetShaderInfoLog(fragmentHandle, 1024, &logLen, &log);

				if (logLen > 0)
				{
					Calc.Log(&log, logLen);
					IsValid = false;
				}
			}
		}

		public ~this()
		{
			GL.glDeleteShader(vertexHandle);
			GL.glDeleteShader(fragmentHandle);
		}
	}
}
