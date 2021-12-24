using System;

namespace Strawberry
{
	public class Updater : Component, IUpdate
	{
		private delegate void() update ~ delete _;

		public this(delegate void() update)
		{
			this.update = update;
		}

		public void Update()
		{
			update?.Invoke();
		}
	}
}