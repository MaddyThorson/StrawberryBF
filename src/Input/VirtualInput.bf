namespace Strawberry
{
	public abstract class VirtualInput
	{
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
