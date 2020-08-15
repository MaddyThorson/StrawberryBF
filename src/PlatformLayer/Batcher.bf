using System.Collections;
using System;

namespace Strawberry
{
	public class Batcher
	{
		static public int VertexSize => sizeof(Vertex);

		private List<Batch> batchStack = new List<Batch>() ~ DeleteContainerAndItems!(_); 
		private Batch top => batchStack.Count > 0 ? batchStack[batchStack.Count - 1] : null;

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
			GL.glVertexAttribPointer(0, 2, GL.GL_FLOAT, GL.GL_FALSE, Batcher.VertexSize, (void*)0);
			GL.glEnableVertexAttribArray(1);
			GL.glVertexAttribPointer(1, 2, GL.GL_FLOAT, GL.GL_FALSE, Batcher.VertexSize, (void*)8);
			GL.glEnableVertexAttribArray(2);
			GL.glVertexAttribPointer(2, 4, GL.GL_UNSIGNED_BYTE, GL.GL_TRUE, Batcher.VertexSize, (void*)16);
			GL.glEnableVertexAttribArray(3);
			GL.glVertexAttribPointer(3, 3, GL.GL_UNSIGNED_BYTE, GL.GL_TRUE, Batcher.VertexSize, (void*)20);
			GL.glBufferData(GL.GL_ARRAY_BUFFER, vertices.Count * sizeof(Vertex), vertices.Ptr, GL.GL_DYNAMIC_DRAW);

			GL.glBindBuffer(GL.GL_ELEMENT_ARRAY_BUFFER, indexBufferID);
			GL.glBufferData(GL.GL_ELEMENT_ARRAY_BUFFER, indices.Count * sizeof(uint32), indices.Ptr, GL.GL_DYNAMIC_DRAW);

			GL.glDrawElements(GL.GL_TRIANGLES, indices.Count, GL.GL_UNSIGNED_INT, (void*)0);
			GL.glBindVertexArray(0);

			vertices.Clear();
			indices.Clear();
		}

		public void PushQuad(Vector a, Vector b, Vector c, Vector d, Color color)
		{
			uint32 count = (uint32)vertices.Count;

			vertices.Add(Vertex.Shape(a, color));
			vertices.Add(Vertex.Shape(b, color));
			vertices.Add(Vertex.Shape(c, color));
			vertices.Add(Vertex.Shape(d, color));

			indices.Add(count + 0);
			indices.Add(count + 1);
			indices.Add(count + 2);
			indices.Add(count + 0);
			indices.Add(count + 2);
			indices.Add(count + 3);
		}

		private class Batch
		{
			uint32 bufferHandle;

			public this()
			{
				//GL.glGenBuffers(1, &bufferHandle);
				//GL.glBindBuffer(GL.GL_ARRAY_BUFFER, bufferHandle);
				//GL.glDeleteBuffers(1, &bufferHandle);
			}
		}

		[Ordered, Packed, CRepr]
		private struct Vertex
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
}
