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
		public Mat4x4 Matrix;
		public int IndicesStart;
		public int IndicesCount;
		public Texture Texture;
		public BatchModes Mode;

		public this(Mat4x4 matrix, BatchModes mode, Texture texture, int start)
		{
			Matrix = matrix;
			Mode = mode;
			Texture = texture;
			IndicesStart = start;
			IndicesCount = 0;
		}

		public bool Matches(Mat4x4 matrix, BatchModes mode, Texture texture)
		{
			return Matrix == matrix && Mode == mode && Texture == texture;
		}
	}
}
