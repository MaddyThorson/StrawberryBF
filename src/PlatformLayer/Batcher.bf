using System.Collections;
using System.Diagnostics;

namespace Strawberry
{
	public abstract class Batcher
	{
		protected List<Batch> batches = new .() ~ delete _;
		protected List<Vertex> vertices = new .() ~ delete _;
		protected List<uint32> indices = new .() ~ delete _;
		private List<Mat4x4> matrixStack = new .(20) ~ delete _;

		public Mat4x4 Matrix => matrixStack.Back;

		public this()
		{
			Reset();
		}

		public void Reset()
		{
			ClearMatrix();

			batches.Clear();
			vertices.Clear();
			indices.Clear();
		}

		public void ClearMatrix()
		{
			matrixStack.Clear();
			matrixStack.Add(Game.PlatformLayer.ScreenMatrix);
		}

		public void PushMatrix(Mat4x4 mat)
		{
			matrixStack.Add(mat * matrixStack.Back);
		}

		public void PopMatrix()
		{
			Debug.Assert(matrixStack.Count > 0, "Cannot pop the Matrix Stack when it is empty");
			matrixStack.PopBack();
		}

		public abstract void Draw();

		protected ref Batch GetBatch(BatchModes mode, Texture texture)
		{
			if (batches.Count == 0 || !batches.Back.Matches(Matrix, mode, texture))
				batches.Add(Batch(Matrix, mode, texture, indices.Count));
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

		public void Pixel(int x, int y, Color color)
		{
			Rect(x, y, 1, 1, color);
		}

		public void Tri(Vector a, Vector b, Vector c, Color color)
		{
			PushTri(.Shape, null,
				.Shape(a, color),
				.Shape(b, color),
				.Shape(c, color));
		}

		public void Quad(Vector a, Vector b, Vector c, Vector d, Color color)
		{
			PushQuad(.Shape, null,
				.Shape(a, color),
				.Shape(b, color),
				.Shape(c, color),
				.Shape(d, color)); 
		}

		public void Tex(Texture texture, Vector pos)
		{
			PushQuad(.TextureTint, texture,
				.Tex(.(pos.X, pos.Y), .(0, 0), Color.White),
				.Tex(.(pos.X + texture.Width, pos.Y), .(1, 0), Color.White),
				.Tex(.(pos.X + texture.Width, pos.Y + texture.Height), .(1, 1), Color.White),
				.Tex(.(pos.X, pos.Y + texture.Height), .(0, 1), Color.White));
		}

		public void Tex(Texture texture, Vector pos, Vector origin, Vector scale, float rotation)
		{
			//TODO!
			PushQuad(.TextureTint, texture,
				.Tex(.(pos.X, pos.Y), .(0, 0), Color.White),
				.Tex(.(pos.X + texture.Width, pos.Y), .(1, 0), Color.White),
				.Tex(.(pos.X + texture.Width, pos.Y + texture.Height), .(1, 1), Color.White),
				.Tex(.(pos.X, pos.Y + texture.Height), .(0, 1), Color.White));
		}
	}
}
