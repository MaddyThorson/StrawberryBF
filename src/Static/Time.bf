namespace Strawberry
{
	static public class Time
	{
		static public float Elapsed;
		static public float PreviousElapsed;
		static public float Rate = 1f;
		static public float Freeze;

		static public float RawDelta => (1 / 60f);
		static public float Delta => RawDelta * Rate;

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
