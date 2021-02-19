namespace Strawberry
{
	public abstract class Module
	{
		public enum RunResults { Quit, Swap }

		public PlatformLayer PlatformLayer { get; private set; }

		private float msCounter;
		private uint32 prevTicks;

		public this(PlatformLayer platformLayer)
		{
			PlatformLayer = platformLayer;
		}

		public Module Run()
		{
			while (true)
			{
				let tick = PlatformLayer.Ticks;
				msCounter += tick - prevTicks;

				// update
				if (Time.FixedTimestep)
				{
					Time.RawDelta = Time.TargetDeltaTime;
					while (msCounter >= Time.TargetMilliseconds)
					{
						msCounter -= Time.TargetMilliseconds;
						PlatformLayer.UpdateInput();
						Update();
						Input.AfterUpdate();
					}
				}
				else
				{
					Time.RawDelta = (tick - prevTicks) / 1000f;
					PlatformLayer.UpdateInput();
					Update();
					Input.AfterUpdate();
				}

				// render
				Render();

				// exit or swap to another module
				if (PlatformLayer.Closed())
					return null;
				else if (Input.KeyPressed(.F1))
				{
					let swapTo = CreateSwapModule();
					if (swapTo != null)
						return swapTo;
				}

				prevTicks = tick;
			}	
		}

		protected abstract void Update();
		protected abstract void Render();

		public virtual Module CreateSwapModule()
		{
			return null;
		}
	}
}
