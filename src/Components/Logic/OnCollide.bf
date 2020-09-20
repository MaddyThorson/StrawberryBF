using System.Collections;
namespace Strawberry
{
	public class OnCollide<T> : Component where T : Entity
	{
		// Takes as parameter the T collided with. Return false to stop checking for collisions until next frame.
		public delegate bool(T) Action;

		public this(delegate bool(T) action)
			: base(true, false)
		{
			Action = action;
		}

		public ~this()
		{
			delete Action;
		}

		public override void Update()
		{
			if (Action != null)
			{
				let list = Entity.Scene.All<T>(scope List<T>());
				for (let t in list)
					if (Entity.Check(t) && !Action(t))
						break;
			}
		}
	}
}
