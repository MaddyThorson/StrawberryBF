using System;
namespace Strawberry
{
	public class Tween : Component
	{
		public Ease.Easer Easer;
		public delegate void(float) OnUpdate;
		public delegate void() OnComplete;
		public bool RemoveOnComplete;

		public float T { get; private set; }

		public this(Ease.Easer easer = null, delegate void(float) onUpdate = null, delegate void() onComplete = null, bool removeOnComplete = true, bool start = true)
			: base(start, false)
		{
			Easer = easer;
			OnUpdate = onUpdate;
			OnComplete = onComplete;
			RemoveOnComplete = removeOnComplete;
		}

		public float Eased => Easer != null ? Easer(T) : T;

		public void Play()
		{
			T = 0;
			Active = true;
		}

		public override void Started()
		{

		}

		public override void Update()
		{
			T = Math.Min(T + Time.Delta, 1);
			OnUpdate?.Invoke(Eased);

			if (T >= 1)
			{
				OnComplete?.Invoke();
				Active = false;
				if (RemoveOnComplete)
					RemoveSelf();
			}
		}

		public override void Draw()
		{

		}
	}
}
