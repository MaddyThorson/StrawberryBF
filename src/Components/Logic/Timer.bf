using System;
using System.Diagnostics;

namespace Strawberry
{
	public class Timer : Component, IUpdate
	{
		private float value;

		public Action OnComplete ~ delete _;
		public bool RemoveOnComplete;

		public this(Action onComplete = null, bool destroyOnComplete = false)
		{
			OnComplete = onComplete;
			RemoveOnComplete = destroyOnComplete;
		}

		public this(float value, Action onComplete, bool destroyOnComplete = false)
		{
			Value = value;
			OnComplete = onComplete;
			RemoveOnComplete = destroyOnComplete;
		}

		public void Update()
		{
			if (value > 0)
			{
				value -= Time.Delta;
				if (value <= 0)
				{
					value = 0;
					OnComplete?.Invoke();
					if (RemoveOnComplete)
						RemoveSelf();
				}
			}
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
			}
		}

		[Inline]
		public void Clear()
		{
			value = 0;
		}

		static public implicit operator bool(Timer timer)
		{
			return timer.value > 0;
		}
	}
}
