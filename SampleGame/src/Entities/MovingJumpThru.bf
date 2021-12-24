namespace Strawberry.Sample
{
	public class MovingJumpThru : Component, IUpdate
	{
		static public Entity Create(Point pos, int width, Point moveTo, float moveTime)
		{
			let e = new Entity(pos);

			let hitbox = e.Add(new Hitbox(0, 0, width, 4));
			let jumpThru = e.Add(new JumpThru(hitbox));
			e.Add(new MovingJumpThru(jumpThru, moveTo, moveTime));
			e.Add(new DrawHitbox(hitbox, .LightGray));

			return e;
		}

		private JumpThru jumpThru;
		private Point moveFrom;
		private Point moveTo;
		private float moveTime;
		private float movingLerp = 0;
		private bool movingPositive = true;

		public this(JumpThru jumpThru, Point moveTo, float moveTime)
		{
			this.jumpThru = jumpThru;
			this.moveTo = moveTo;
			this.moveTime = moveTime;
		}

		protected override void Awake()
		{
			moveFrom = Entity.Position;
		}

		public void Update()
		{
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
			jumpThru.MoveTo(target);
		}
	}
}
