namespace Strawberry
{
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
}
