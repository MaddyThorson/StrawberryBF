namespace Strawberry
{
	public abstract class VirtualInput
	{
		public enum OverlapBehaviors { TakeNewer, TakeOlder, CancelOut }
		public enum ThresholdConditions { GreaterThan, LessThan }

		public this()
		{
			Game.VirtualInputs.Add(this);
		}

		public ~this()
		{
			Game.VirtualInputs.Remove(this);
		}

		public virtual void Update()
		{

		}
	}
}
