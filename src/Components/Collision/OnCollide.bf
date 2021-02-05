using System.Collections;
namespace Strawberry
{
	public class OnCollide<T> : Component, IHasHitbox, IUpdate where T : Component, IHasHitbox
	{
		public Hitbox Hitbox { get; private set; }

		// Takes as parameter the T collided with. Return false to stop checking for collisions until next frame.
		public delegate bool(T) Action;

		public this(Hitbox hitbox, delegate bool(T) action)
		{
			Hitbox = hitbox;
			Action = action;
		}

		public ~this()
		{
			delete Action;
		}

		public void Update()
		{
			if (Action != null)
			{
				let list = Entity.Scene.All<T>(scope List<T>());
				for (let t in list)
					if (Hitbox.Check(t) && !Action(t))
						break;
			}
		}
	}
}
