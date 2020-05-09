using System;
using System.Diagnostics;

namespace Strawberry
{
	public class Timer : Component
	{
		private float value;

		public Action OnComplete ~ delete _;
		public bool RemoveOnComplete;

		public this()
			: base(false, false)
		{
			
		}

		public this(float value, Action onComplete, bool destroyOnComplete = false)
			: base(false, false)
		{
			Value = value;
			OnComplete = onComplete;
			RemoveOnComplete = destroyOnComplete;
		}

		public float Value
		{
			[Inline]
			get
			{
				return value;
			}

			[Inline]
			set
			{
				this.value = Math.Max(0, value);
				Active = (this.value > 0);
			}
		}

		[Inline]
		public void Clear()
		{
			value = 0;
			Active = false;
		}

		public override void Update()
		{
			if (value > 0)
			{
				value -= Time.Delta;
				if (value <= 0)
				{
					value = 0;
					Active = false;

					OnComplete?.Invoke();
					if (RemoveOnComplete)
						RemoveSelf();
				}
			}
		}

		static public implicit operator bool(Timer timer)
		{
			return timer.value > 0;
		}
	}
}
