using System;
using System.Collections;

namespace Strawberry
{
	public class Entity
	{
		public Scene Scene { get; private set; }
		public int Depth;
		public bool Active = true;
		public bool Visible = true;
		public bool Collidable = true;
		public bool DeleteOnRemove = true;

		public this(Point position)
		{
			Positionf = position;
		}

		public void Added(Scene scene)
		{
			Scene = scene;
		}

		public void Removed()
		{
			Scene = null;
		}

		public virtual void Started()
		{

		}

		public virtual void Update()
		{

		}

		public virtual void Draw()
		{
			
		}

		[Inline]
		public void RemoveSelf()
		{
			Scene?.Remove(this);
		}

		// ===== Position =====

		public Vector Positionf;

		public float Xf
		{
			[Inline]
			get
			{
				return Positionf.X;
			}

			[Inline]
			set
			{
				Positionf.X = value;
			}
		}

		public float Yf
		{
			[Inline]
			get
			{
				return Positionf.Y;
			}

			[Inline]
			set
			{
				Positionf.Y = value;
			}
		}

		public Point Position
		{
			[Inline]
			get
			{
				return Positionf.Round();
			}

			[Inline]
			set
			{
				Positionf = value;
			}
		}

		public int X
		{
			[Inline]
			get
			{
				return (int)Math.Round(Positionf.X);
			}

			[Inline]
			set
			{
				Positionf.X = value;
			}
		}

		public int Y
		{
			[Inline]
			get
			{
				return (int)Math.Round(Positionf.Y);
			}

			[Inline]
			set
			{
				Positionf.Y = value;
			}
		}

		// ===== Hitbox =====

		public Rect Hitbox;

		public int Width
		{
			[Inline]
			get
			{
				return Hitbox.Width;
			}

			[Inline]
			set
			{
				Hitbox.Width = value;
			}
		}

		public int Height
		{
			[Inline]
			get
			{
				return Hitbox.Height;
			}

			[Inline]
			set
			{
				Hitbox.Height = value;
			}
		}

		public Rect SceneHitbox
		{
			[Inline]
			get
			{
				return Hitbox + Position;
			}
		}

		public int Left
		{
			[Inline]
			get
			{
				return Position.X + Hitbox.Left;
			}

			[Inline]
			set
			{
				X = value - Hitbox.Left;
			}
		}

		public int Right
		{
			[Inline]
			get
			{
				return Position.X + Hitbox.Right;
			}

			[Inline]
			set
			{
				Y = value - Hitbox.Right;
			}
		}

		public int Top
		{
			[Inline]
			get
			{
				return Position.Y + Hitbox.Top;
			}

			[Inline]
			set
			{
				Y = value - Hitbox.Top;
			}
		}

		public int Bottom
		{
			[Inline]
			get
			{
				return Position.Y + Hitbox.Bottom;
			}

			[Inline]
			set
			{
				Y = value - Hitbox.Bottom;
			}
		}

		// ===== Collisions =====

		public bool Check(Point point)
		{
			return SceneHitbox.Contains(point);
		}

		public bool Check(Rect rect)
		{
			return SceneHitbox.Intersects(rect);
		}

		public bool Check(Entity other)
		{
			return other.Collidable && SceneHitbox.Intersects(other.SceneHitbox);
		}

		public bool Check(Entity other, Point offset)
		{
			return other.Collidable && (SceneHitbox + offset).Intersects(other.SceneHitbox);
		}

		public bool CheckOutside(Entity other, Point offset)
		{
			return other.Collidable && !SceneHitbox.Intersects(other.SceneHitbox) && (SceneHitbox + offset).Intersects(other.SceneHitbox);
		}

		public bool Check<T>() where T : Entity
		{
			for (var e in Scene.All<T>(scope List<T>))
				if (Check(e))
					return true;

			return false;
		}

		public bool Check<T>(Point offset) where T : Entity
		{
			for (var e in Scene.All<T>(scope List<T>))
				if (Check(e, offset))
					return true;

			return false;
		}

		public bool CheckOutside<T>(Point offset) where T : Entity
		{
			for (var e in Scene.All<T>(scope List<T>))
				if (CheckOutside(e, offset))
					return true;

			return false;
		}

		public T First<T>() where T : Entity
		{
			for (var e in Scene.All<T>(scope List<T>))
				if (Check(e))
					return e;

			return null;
		}

		public T First<T>(Point offset) where T : Entity
		{
			for (var e in Scene.All<T>(scope List<T>))
				if (Check(e, offset))
					return e;

			return null;
		}

		public T FirstOutside<T>(Point offset) where T : Entity
		{
			for (var e in Scene.All<T>(scope List<T>))
				if (CheckOutside(e, offset))
					return e;

			return null;
		}

		public List<T> All<T>(List<T> into) where T : Entity
		{
			for (var e in Scene.All<T>(scope List<T>))
				if (Check(e))
					into.Add(e);

			return into;
		}

		public List<T> All<T>(Point offset, List<T> into) where T : Entity
		{
			for (var e in Scene.All<T>(scope List<T>))
				if (Check(e, offset))
					into.Add(e);

			return into;
		}

		public List<T> AllOutside<T>(Point offset, List<T> into) where T : Entity
		{
			for (var e in Scene.All<T>(scope List<T>))
				if (CheckOutside(e, offset))
					into.Add(e);

			return into;
		}

		// ===== Misc =====

		public void DrawHitbox(SDL2.SDL.Color color)
		{
			Draw.Rect(SceneHitbox, color);
		}

		static public int operator<=>(Entity a, Entity b)
		{
			return a.Depth <=> b.Depth;
		}
	}
}
