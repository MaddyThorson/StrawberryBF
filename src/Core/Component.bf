using System;

namespace Strawberry
{
	public abstract class Component
	{
		public Entity Entity { get; private set; }

		private void Added(Entity entity)
		{
			Entity = entity;
		}

		private void Removed()
		{
			Entity = null;
		}

		public virtual void Started() { }
		public virtual void Ended() { }

		[Inline]
		public void RemoveSelf()
		{
			Entity?.Remove(this);
		}

		[Inline]
		public Scene Scene => Entity?.Scene;

		[Inline]
		public T SceneAs<T>() where T : Scene
		{
			return Entity.SceneAs<T>();
		}
	}
}
