using System;
using System.Diagnostics;

namespace Strawberry
{
	static public class Calc
	{
		[Inline]
		static public float Approach(float value, float target, float maxDelta)
		{
			return value > target ? Math.Max(value - maxDelta, target) : Math.Min(value + maxDelta, target);
		}

		[Inline]
		static public float Map(float value, float oldMin, float oldMax)
		{
			return (value - oldMin) / (oldMax - oldMin);
		}

		[Inline]
		static public float Map(float value, float oldMin, float oldMax, float newMin, float newMax)
		{
			return newMin + (newMax - newMin) * Map(value, oldMin, oldMax);
		}

		[Inline]
		static public float ClampedMap(float value, float oldMin, float oldMax)
		{
			return Math.Clamp((value - oldMin) / (oldMax - oldMin), 0, 1);
		}

		[Inline]
		static public float ClampedMap(float value, float oldMin, float oldMax, float newMin, float newMax)
		{
			return newMin + (newMax - newMin) * ClampedMap(value, oldMin, oldMax);
		}

		static public void Log()
		{
			Debug.WriteLine("***");
		}

		static public void Log<T>(T v)
		{
			String string = scope String;
			v.ToString(string);
			Debug.WriteLine(string);
		}
	}
}
