using System;
namespace Strawberry
{
	public class Tween : Component, IUpdate
	{
		public Ease.Easer Easer ~ delete _;
		public delegate void(float) OnUpdate ~ delete _;
		public delegate void() OnComplete ~ delete _;
		public bool DestroyOnComplete;

		public bool Playing { get; private set; }
		public float T { get; private set; }

		public this(Ease.Easer easer = null, delegate void(float) onUpdate = null, delegate void() onComplete = null, bool removeOnComplete = true, bool start = true)
		{
			Playing = start;
			Easer = easer;
			OnUpdate = onUpdate;
			OnComplete = onComplete;
			DestroyOnComplete = removeOnComplete;
		}

		[Inline]
		public float Eased => Easer != null ? Easer(T) : T;

		[Inline]
		public void Play()
		{
			T = 0;
			Playing = true;
		}

		[Inline]
		public void Stop()
		{
			Playing = false;
		}

		public void Update()
		{
			T = Math.Min(T + Time.Delta, 1);
			OnUpdate?.Invoke(Eased);

			if (T >= 1)
			{
				OnComplete?.Invoke();
				Playing = false;
				if (DestroyOnComplete)
					Destroy();
			}
		}
	}
}
