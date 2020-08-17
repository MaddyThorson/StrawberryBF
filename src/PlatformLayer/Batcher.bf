namespace Strawberry
{
	public abstract class Batcher
	{
		public abstract void Draw();

		protected abstract void PushQuad(Vertex a, Vertex b, Vertex c, Vertex d);
		protected abstract void PushTri(Vertex a, Vertex b, Vertex c);

		public void Rect(float x, float y, float w, float h, Color color)
		{
			PushQuad(.Shape(.(x, y), color), .Shape(.(x + w, y), color), .Shape(.(x + w, y + h), color), .Shape(.(x, y + h), color)); 
		}

		public void Rect(Rect rect, Color color)
		{
			Rect(rect.X, rect.Y, rect.Width, rect.Height, color);
		}
	}
}
