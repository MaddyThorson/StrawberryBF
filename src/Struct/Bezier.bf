namespace Strawberry
{
	public struct Bezier
	{
		public Vector Start;
		public Vector Control;
		public Vector End;

		public this(Vector start, Vector control, Vector end)
		{
			Start = start;
			Control = control;
			End = end;
		}

		public Vector this[float t]
		{
			get => (Start * (1 - t) * (1 - t)) + (Control * 2f * (1 - t) * t) + (End * t * t);
		}

		public float GetLengthParametric(int resolution)
		{
		    Vector last = Start;
		    float length = 0;
		    for (int i = 1; i <= resolution; i++)
		    {
		        Vector at = this[i / (float)resolution];
		        length += (at - last).Length;
		        last = at;
		    }

		    return length;
		}
	}
}
