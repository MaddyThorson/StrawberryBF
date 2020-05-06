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
