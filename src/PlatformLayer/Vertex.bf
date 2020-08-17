using System;

namespace Strawberry
{
	[Ordered, Packed, CRepr]
	public struct Vertex
	{
		public Vector Position;
		public Vector TexCoord;
		public Color Color;
		public (uint8, uint8, uint8) Mode;

		static public Vertex Shape(Vector pos, Color color)
		{
			Vertex v = Vertex();
			v.Position = pos;
			v.Color = color;
			v.Mode = (0, 0, 255);
			return v;
		}
	}
}
