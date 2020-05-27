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

		private void Added(Entity entity)
		{
			Entity = entity;
		}

		private void Removed()
		{
			Entity = null;
		}

		public abstract void Started();
		public abstract void Update();
		public abstract void Draw();

		[Inline]
		public void RemoveSelf()
		{
			Entity?.Remove(this);
		}
	}
}
