using System;

namespace Strawberry
{
	static public class Ease
	{
		public delegate float Easer(float t);

		static public float CubeIn(float t)
		{
			return t * t * t;
		}

		static public float CubeOut(float t)
		{
			return Invert(t, scope => CubeIn);
		}

		static public float CubeInOut(float t)
		{
			return Follow(t, scope => CubeIn, scope => CubeOut);
		}

		[Inline]
		static public float Invert(float t, Easer easer)
		{
		    return 1 - easer(1 - t);
		}

		[Inline]
		static public float Follow(float t, Easer a, Easer b)
		{
			return (t <= 0.5f) ? a(t * 2) / 2 : b(t * 2 - 1) / 2 + 0.5f;
		}
	}
}
