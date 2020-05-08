using System;

namespace Strawberry
{
	public abstract class Component
	{
		public Entity Entity { get; private set; }

		public bool Active;
		public bool Visible;

		public this(bool active, bool visible)
		{
			Active = active;
			Visible = visible;
		}

		public void	Added(Entity entity)
		{
			Entity = entity;
		}

		public void Removed()
		{
			Entity = null;
		}

		public virtual void Started()
		{

		}

		public virtual void Update()
		{

		}

		public virtual void Draw()
		{

		}

		[Inline]
		public void RemoveSelf()
		{
			Entity?.Remove(this);
		}
	}
}
