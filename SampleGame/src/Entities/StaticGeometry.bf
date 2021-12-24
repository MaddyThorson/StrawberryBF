using System;

namespace Strawberry.Sample
{
	static public class StaticGeometry
	{
		static public Entity CreateSolid(Point pos, Rect bounds)
		{
			let e = new Entity(pos);

			let hitbox = e.Add(new Hitbox(bounds));
			e.Add(new Solid(hitbox));
			e.Add(new DrawHitbox(hitbox, .White));

			return e;
		}

		static public Entity CreateJumpThru(Point pos, int width)
		{
			let e = new Entity(pos);

			let hitbox = e.Add(new Hitbox(0, 0, width, 4));
			e.Add(new JumpThru(hitbox));
			e.Add(new DrawHitbox(hitbox, .LightGray));

			return e;
		}
	}
}