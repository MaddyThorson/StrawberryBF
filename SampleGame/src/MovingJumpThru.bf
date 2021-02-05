namespace Strawberry.Sample
{
	public class MovingJumpThru	: OldJumpThru
	{
		private Point moveFrom;
		private Point moveTo;
		private float moveTime;

		private float movingLerp;
		private bool movingPositive;

		public this(Point pos, int width, Point moveTo, float moveTime)
			: base(pos, width)
		{
			moveFrom = Position;
			this.moveTo = moveTo;
			this.moveTime = moveTime;

			movingLerp = 0;
			movingPositive = true;
		}

		public override void Update()
		{
			base.Update();

			if (movingPositive)
			{
				movingLerp += Time.Delta / moveTime;
				if (movingLerp >= 1)
				{
					movingLerp = 1;
					movingPositive = false;
				}
			}
			else
			{
				movingLerp -= Time.Delta / moveTime;
				if (movingLerp <= 0)
				{
					movingLerp = 0;
					movingPositive = true;
				}
			}

			let target = Vector.Lerp(moveFrom, moveTo, Ease.CubeInOut(movingLerp));
			MoveTo(target);
		}
	}
}
