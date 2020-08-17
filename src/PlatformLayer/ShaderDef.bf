using System;

namespace Strawberry
{
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
