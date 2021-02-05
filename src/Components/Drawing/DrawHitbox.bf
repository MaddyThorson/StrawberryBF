namespace Strawberry
{
	public class DrawHitbox : Component, IHasHitbox, IDraw
	{
		public Hitbox Hitbox { get; private set; }
		public Color Color;

		public this(Hitbox hitbox, Color color)
		{
			Hitbox = hitbox;
			Color = color;
		}

		public void Draw()
		{
			Game.Batcher.Rect(Hitbox.SceneHitbox, Color);
		}
	}
}
