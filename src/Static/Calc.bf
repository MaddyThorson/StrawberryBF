using System;
using System.Diagnostics;

namespace Strawberry
{
	static public class Calc
	{
		public const float Circle 	= Math.PI_f * 2;
		public const float Right 	= 0;
		public const float Left 	= Math.PI_f;
		public const float Up 		= Math.PI_f * -0.5f;
		public const float Down 	= Math.PI_f * 0.5f;
		public const float DegToRad = Math.PI_f / 180f;
		public const float RadToDeg = 180f / Math.PI_f;

		[Inline]
		static public bool BitCheck(int bits, int pos)
		{
		    return (bits & (1 << pos)) != 0;
		}

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
		static public bool OnInterval(float current, float previous, float interval, float startDelay = 0)
		{
			return current >= startDelay && (int)((current - startDelay) / interval) != (int)((previous - startDelay) / interval);
		}

		[Inline]
		static public bool BetweenInterval(float current, float interval, float startDelay = 0)
		{
			return current >= startDelay && (current - startDelay) % (interval * 2) >= interval;
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

		[Inline]
		static public void Log(delegate void(String) del)
		{
			String string = scope String();
			del(string);
			Debug.WriteLine(string);
		}

		static private String StringArgs(String str, Object[] args)
		{
			for (let i < args.Count)
			{
				String arg = scope String();
				String num = scope String("{x}");
				i.ToString(arg);
				num.Replace("x", arg);

				arg.Clear();
				args[i].ToString(arg);
				str.Replace(num, arg);
			}

			return str;
		}

		static public void Log(StringView str, params Object[] args)
		{
			let string = StringArgs(scope String(str), args);
			Debug.WriteLine(string);
		}
	}
}
