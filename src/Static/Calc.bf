using System;
using System.Diagnostics;

namespace Strawberry
{
	static public class Calc
	{
		//Move toward a target value without crossing it
		[Inline]
		static public float Approach(float value, float target, float maxDelta)
		{
			return value > target ? Math.Max(value - maxDelta, target) : Math.Min(value + maxDelta, target);
		}

		//Convert from a value between arbitrary min and max to between 0 and 1
		[Inline]
		static public float Map(float value, float oldMin, float oldMax)
		{
			return (value - oldMin) / (oldMax - oldMin);
		}

		[Inline]
		//Convert from a value between arbitrary min and max to between any other min and max
		static public float Map(float value, float oldMin, float oldMax, float newMin, float newMax)
		{
			return newMin + (newMax - newMin) * Map(value, oldMin, oldMax);
		}

		[Inline]
		//Convert from a value between arbitrary min and max to between 0 and 1, and clamp it between 0 and 1
		static public float ClampedMap(float value, float oldMin, float oldMax)
		{
			return Math.Clamp((value - oldMin) / (oldMax - oldMin), 0, 1);
		}

		[Inline]
		//Convert from a value between arbitrary min and max to between any other min and max, and clamp it within that range
		static public float ClampedMap(float value, float oldMin, float oldMax, float newMin, float newMax)
		{
			return newMin + (newMax - newMin) * ClampedMap(value, oldMin, oldMax);
		}

		[Inline]
		static public void Log()
		{
			Debug.WriteLine("***");
		}

		[Inline]
		static public void Log<T>(T v)
		{
			String string = scope String();
			v.ToString(string);
			Debug.WriteLine(string);
		}
	}
}
