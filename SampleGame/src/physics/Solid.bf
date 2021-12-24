using System.Collections;

namespace Strawberry.Sample
{
	public class Solid : Component, IHasHitbox
	{
		public Hitbox Hitbox { get; private set; }

		private Vector remainder;

		public Vector ExactPosition => Entity.Position + remainder;

		public this(Hitbox hitbox)
		{
			Hitbox = hitbox;
		}


	}
}
