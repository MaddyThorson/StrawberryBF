using System;

namespace Strawberry
{
	public abstract class Component
	{
		public Entity Entity { get; private set; }
		public bool IsAwake { get; private set; }

		public virtual void Added() { }
		public virtual void Awake() { }
		public virtual void End() { }

		[Inline]
		public void Destroy()
		{
			Entity.Destroy();
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
