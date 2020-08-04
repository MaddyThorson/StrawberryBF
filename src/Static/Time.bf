namespace Strawberry
{
	static public class Time
	{
		static public bool FixedTimestep = true;
		static public float TargetDeltaTime = 1 / 60f;
		static public float Elapsed;
		static public float PreviousElapsed;
		static public float RawElapsed;
		static public float RawPreviousElapsed;
		static public float Rate = 1f;
		static public float Freeze;
		static public float RawDelta;

		static public float Delta => RawDelta * Rate;
		static public float TargetMilliseconds => 1000 * TargetDeltaTime;

		static public bool OnInterval(float interval, float startDelay = 0)
		{
			return Calc.OnInterval(Elapsed, PreviousElapsed, interval, startDelay);
		}

		static public bool BetweenInterval(float interval, float startDelay = 0)
		{
			return Calc.BetweenInterval(Time.Elapsed, interval, startDelay);
		}
	}
}
