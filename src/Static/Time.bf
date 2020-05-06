namespace Strawberry
{
	static public class Time
	{
		static public float Elapsed;
		static public float PreviousElapsed;
		static public float Delta = 1 / 60f;

		static public bool OnInterval(float interval, float offset = 0)
		{
			return (int)((Elapsed - offset) / interval) != (int)((PreviousElapsed - offset) / interval);
		}

		static public bool BetweenInterval(float interval, float offset = 0)
		{
			return (Elapsed - offset) % (interval * 2) >= interval;
		}
	}
}
