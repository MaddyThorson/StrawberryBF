using System.Collections.Generic;

namespace Strawberry
{
	public class Batcher
	{
		List<Batch> batchStack = new System.Collections.List<Batch>() ~ DeleteContainerAndItems!(_); 

		Batch top => batchStack.Count > 0 ? batchStack[batchStack.Count - 1] : null;

		private class Batch
		{

		}
	}
}
