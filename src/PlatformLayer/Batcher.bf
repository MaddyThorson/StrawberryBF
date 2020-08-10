using System.Collections.Generic;

namespace Strawberry
{
	public class Batcher
	{
		List<Batch> batchStack = new System.Collections.List<Batch>() ~ DeleteContainerAndItems!(_); 

		Batch top => batchStack.Count > 0 ? batchStack[batchStack.Count - 1] : null;

		public void PushQuad(Vertex a, Vertex b, Vertex c, Vertex d)
		{
			
		}

		private class Batch
		{
			uint32 bufferHandle;

			List<Vertex> Vertices;

			public this()
			{
				GL.glGenBuffers(1, &bufferHandle);
				GL.glBindBuffer(GL.GL_ARRAY_BUFFER, bufferHandle);
				GL.glDeleteBuffers(1, &bufferHandle);
			}
		}

		private struct Vertex
		{
			public Vector Position;
			public Color Color;
		}
	}
}
