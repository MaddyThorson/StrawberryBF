namespace Strawberry
{
	public class Image : Component, IDraw
	{
		public Texture Texture;
		public Point Offset;
		public Point Origin;
		public float Rotation;
		public Vector Scale = .One;

		public this(Texture texture, Point origin = .Zero, Point offset = .Zero)
		{
			Texture = texture;
			Origin = origin;
			Offset = offset;
		}

		public Point DrawPosition => Entity.Position + Offset - Origin;

		public void Draw()
		{
			if (Texture != null)
				Game.Batcher.Tex(Texture, DrawPosition);
		}
	}
}
