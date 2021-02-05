using System.Collections;

namespace Strawberry.Sample
{
	public class JumpThru : Component, IHasHitbox
	{
		public Hitbox Hitbox { get; private set; }

		public this(Hitbox hitbox)
		{
			Hitbox = hitbox;
		}
	}
}
