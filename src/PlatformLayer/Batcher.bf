using System.Collections;

namespace Strawberry
{
	public abstract class Batcher
	{
		protected List<Batch> batches = new .() ~ delete _;
		protected List<Vertex> vertices = new .() ~ delete _;
		protected List<uint32> indices = new .() ~ delete _;

		public abstract void Draw();

		protected ref Batch GetBatch(BatchModes mode, Texture texture)
		{
			if (batches.Count == 0 || !batches.Back.Matches(mode, texture))
				batches.Add(Batch(mode, texture, indices.Count));
			return ref batches.Back;
		}

		protected abstract void PushQuad(BatchModes mode, Texture texture, Vertex a, Vertex b, Vertex c, Vertex d);
		protected abstract void PushTri(BatchModes mode, Texture texture, Vertex a, Vertex b, Vertex c);

		public void Rect(float x, float y, float w, float h, Color color)
		{
			PushQuad(.Shape, null,
				.Shape(.(x, y), color),
				.Shape(.(x + w, y), color),
				.Shape(.(x + w, y + h), color),
				.Shape(.(x, y + h), color)); 
		}

		public void Rect(Rect rect, Color color)
		{
			Rect(rect.X, rect.Y, rect.Width, rect.Height, color);
		}

		public void Tex(Texture texture, float x, float y)
		{
			PushQuad(.TextureTint, texture,
				.Tex(.(x, y), .(0, 1), Color.White),
				.Tex(.(x + texture.Width, y), .(1, 1), Color.White),
				.Tex(.(x + texture.Width, y + texture.Height), .(1, 0), Color.White),
				.Tex(.(x, y + texture.Height), .(0, 0), Color.White));
		}
	}
}
