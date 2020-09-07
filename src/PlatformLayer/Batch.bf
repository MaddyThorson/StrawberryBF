namespace Strawberry
{
	public enum BatchModes
	{
		TextureTint,
		TextureWash,
		Shape,
	}

	public struct Batch
	{
		public int IndicesStart;
		public int IndicesCount;
		public Texture Texture;
		public BatchModes Mode;

		public this(BatchModes mode, Texture texture, int start)
		{
			Mode = mode;
			Texture = texture;
			IndicesStart = start;
			IndicesCount = 0;
		}

		public bool Matches(BatchModes mode, Texture texture)
		{
			return Mode == mode && Texture == texture;
		}
	}
}
