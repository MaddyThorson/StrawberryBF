using System;
using System.Diagnostics;

namespace Strawberry
{
	public class Timer : Component
	{
		private float value;

		public Action OnComplete ~ delete _;
		public bool DestroyOnComplete;

		public this()
			: base(false, false)
		{
			
		}

		public this(float value, Action onComplete, bool destroyOnComplete = false)
			: base(false, false)
		{
			Value = value;
			OnComplete = onComplete;
			DestroyOnComplete = destroyOnComplete;
		}

		public float Value
		{
			get
			{
				return value;
			}

			set
			{
				this.value = Math.Max(0, value);
				Active = (this.value > 0);
			}
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
					if (DestroyOnComplete)
						RemoveSelf();
				}
			}
		}
	}
}
