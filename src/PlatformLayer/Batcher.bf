using System.Collections;

namespace Strawberry
{
	public class Batcher
	{
		private List<Batch> batches = new .() ~ delete _;
		private List<Vertex> vertices = new .() ~ delete _;
		private List<uint32> indices = new .() ~ delete _;

		private uint32 vaoID;
		private uint32 vertexBufferID;
		private uint32 indexBufferID;

		public this()
		{
			GL.glGenVertexArrays(1, &vaoID);
			GL.glBindVertexArray(vaoID);
			GL.glGenBuffers(1, &vertexBufferID);
			GL.glGenBuffers(1, &indexBufferID);
			GL.glBindVertexArray(0);
		}

		public ~this()
		{
			GL.glDeleteBuffers(1, &vertexBufferID);
			GL.glDeleteBuffers(1, &indexBufferID);
			GL.glDeleteVertexArrays(1, &vaoID);
		}

		public void Draw()
		{
			GL.glDisable(GL.GL_CULL_FACE);

			GL.glBindVertexArray(vaoID);

			GL.glBindBuffer(GL.GL_ARRAY_BUFFER, vertexBufferID);
			GL.glEnableVertexAttribArray(0);
			GL.glVertexAttribPointer(0, 2, GL.GL_FLOAT, GL.GL_FALSE, sizeof(Vertex), (void*)0);
			GL.glEnableVertexAttribArray(1);
			GL.glVertexAttribPointer(1, 2, GL.GL_FLOAT, GL.GL_FALSE, sizeof(Vertex), (void*)8);
			GL.glEnableVertexAttribArray(2);
			GL.glVertexAttribPointer(2, 4, GL.GL_UNSIGNED_BYTE, GL.GL_TRUE, sizeof(Vertex), (void*)16);
			GL.glEnableVertexAttribArray(3);
			GL.glVertexAttribPointer(3, 3, GL.GL_UNSIGNED_BYTE, GL.GL_TRUE, sizeof(Vertex), (void*)20);
			GL.glBufferData(GL.GL_ARRAY_BUFFER, vertices.Count * sizeof(Vertex), vertices.Ptr, GL.GL_DYNAMIC_DRAW);

			GL.glBindBuffer(GL.GL_ELEMENT_ARRAY_BUFFER, indexBufferID);
			GL.glBufferData(GL.GL_ELEMENT_ARRAY_BUFFER, indices.Count * sizeof(uint32), indices.Ptr, GL.GL_DYNAMIC_DRAW);

			for (let b in batches)
			{
				if (b.Mode == .Shape)
					GL.glBindTexture(GL.GL_TEXTURE_2D, 0);
				else
					GL.glBindTexture(GL.GL_TEXTURE_2D, b.Texture.Handle);
				GL.glDrawElements(GL.GL_TRIANGLES, b.IndicesCount, GL.GL_UNSIGNED_INT, (void*)(b.IndicesStart * sizeof(uint32)));
			}
			
			GL.glBindVertexArray(0);

			vertices.Clear();
			indices.Clear();
			batches.Clear();
		}

		private ref Batch GetBatch(BatchModes mode, Texture texture)
		{
			if (batches.Count == 0 || !batches.Back.Matches(mode, texture))
				batches.Add(Batch(mode, texture, indices.Count));
			return ref batches.Back;
		}

		protected void PushQuad(BatchModes mode, Texture texture, Vertex a, Vertex b, Vertex c, Vertex d)
		{
			GetBatch(mode, texture).IndicesCount += 6;

			uint32 count = (uint32)vertices.Count;

			vertices.Add(a);
			vertices.Add(b);
			vertices.Add(c);
			vertices.Add(d);

			indices.Add(count + 0);
			indices.Add(count + 1);
			indices.Add(count + 2);
			indices.Add(count + 0);
			indices.Add(count + 2);
			indices.Add(count + 3);
		}

		protected void PushTri(BatchModes mode, Texture texture, Vertex a, Vertex b, Vertex c)
		{
			GetBatch(mode, texture).IndicesCount += 3;

			uint32 count = (uint32)vertices.Count;

			vertices.Add(a);
			vertices.Add(b);
			vertices.Add(c);

			indices.Add(count + 0);
			indices.Add(count + 1);
			indices.Add(count + 2);
		}

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
