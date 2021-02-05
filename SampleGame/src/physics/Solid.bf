using System.Collections;

namespace Strawberry.Sample
{
	public class Solid : Component, IHasHitbox
	{
		public Hitbox Hitbox { get; private set; }

		public this(Hitbox hitbox)
		{
			Hitbox = hitbox;
		}
	}
}
