using System;
using System.Collections;

namespace Strawberry
{
	public class Hitbox : Component, IDebugDraw
	{
		public bool Collidable = true;
		public Rect Rect;

		public void DebugDraw()
		{
			Game.Batcher.Rect(SceneHitbox, .Red);
		}

		public int Width
		{
			[Inline]
			get
			{
				return Rect.Width;
			}

			[Inline]
			set
			{
				Rect.Width = value;
			}
		}

		public int Height
		{
			[Inline]
			get
			{
				return Rect.Height;
			}

			[Inline]
			set
			{
				Rect.Height = value;
			}
		}

		public Rect SceneHitbox
		{
			[Inline]
			get
			{
				return Rect + Entity.Position;
			}
		}

		public int Left
		{
			[Inline]
			get
			{
				return Entity.X + Rect.Left;
			}

			[Inline]
			set
			{
				Entity.X = value - Rect.Left;
			}
		}

		public int Right
		{
			[Inline]
			get
			{
				return Entity.X + Rect.Right;
			}

			[Inline]
			set
			{
				Entity.X = value - Rect.Right;
			}
		}

		public int Top
		{
			[Inline]
			get
			{
				return Entity.Y + Rect.Top;
			}

			[Inline]
			set
			{
				Entity.Y = value - Rect.Top;
			}
		}

		public int Bottom
		{
			[Inline]
			get
			{
				return Entity.Y + Rect.Bottom;
			}

			[Inline]
			set
			{
				Entity.Y = value - Rect.Bottom;
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

		public bool Check(Grid grid)
		{
			return grid != null && grid.Check(SceneHitbox);
		}

		public bool Check(Grid grid, Point offset)
		{
			return grid != null && grid.Check(SceneHitbox + offset);
		}

		public bool Check(Hitbox other)
		{
			return other.Collidable && SceneHitbox.Intersects(other.SceneHitbox);
		}

		public bool Check(Hitbox other, Point offset)
		{
			return other.Collidable && (SceneHitbox + offset).Intersects(other.SceneHitbox);
		}

		public bool CheckOutside(Hitbox other, Point offset)
		{
			return other.Collidable && !SceneHitbox.Intersects(other.SceneHitbox) && (SceneHitbox + offset).Intersects(other.SceneHitbox);
		}

		public bool Check<T>(T other) where T : Component, IHasHitbox
		{
			return Check(other.Hitbox);
		}

		public bool Check<T>(T other, Point offset) where T : Component, IHasHitbox
		{
			return Check(other.Hitbox, offset);
		}

		public bool CheckOutside<T>(T other, Point offset) where T : Component, IHasHitbox
		{
			return CheckOutside(other.Hitbox, offset);
		}

		public bool Check<T>() where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (Check(e.Hitbox))
					return true;

			return false;
		}

		public bool Check<T>(Point offset) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (Check(e.Hitbox, offset))
					return true;

			return false;
		}

		public bool CheckOutside<T>(Point offset) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (CheckOutside(e.Hitbox, offset))
					return true;

			return false;
		}

		public T First<T>() where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (Check(e.Hitbox))
					return e;

			return null;
		}

		public T First<T>(Point offset) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (Check(e.Hitbox, offset))
					return e;

			return null;
		}

		public T FirstOutside<T>(Point offset) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (CheckOutside(e.Hitbox, offset))
					return e;

			return null;
		}

		public T LeftmostOutside<T>(Point offset) where T : Component, IHasHitbox
		{
			T ret = null;
			for (var e in Scene.All<T>(scope List<T>()))
				if (CheckOutside(e.Hitbox, offset) && (ret == null || e.Hitbox.Left < ret.Hitbox.Left))
					ret = e;

			return ret;
		}

		public T RightmostOutside<T>(Point offset) where T : Component, IHasHitbox
		{
			T ret = null;
			for (var e in Scene.All<T>(scope List<T>()))
				if (CheckOutside(e.Hitbox, offset) && (ret == null || e.Hitbox.Right > ret.Hitbox.Right))
					ret = e;

			return ret;
		}

		public T TopmostOutside<T>(Point offset) where T : Component, IHasHitbox
		{
			T ret = null;
			for (var e in Scene.All<T>(scope List<T>()))
				if (CheckOutside(e.Hitbox, offset) && (ret == null || e.Hitbox.Top < ret.Hitbox.Top))
					ret = e;

			return ret;
		}

		public T BottommostOutside<T>(Point offset) where T : Component, IHasHitbox
		{
			T ret = null;
			for (var e in Scene.All<T>(scope List<T>()))
				if (CheckOutside(e.Hitbox, offset) && (ret == null || e.Hitbox.Bottom > ret.Hitbox.Bottom))
					ret = e;

			return ret;
		}

		public List<T> All<T>(List<T> into) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (Check(e.Hitbox))
					into.Add(e);

			return into;
		}

		public List<T> All<T>(Point offset, List<T> into) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (Check(e.Hitbox, offset))
					into.Add(e);

			return into;
		}

		public List<T> AllOutside<T>(Point offset, List<T> into) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (CheckOutside(e.Hitbox, offset))
					into.Add(e);

			return into;
		}
	}
}
