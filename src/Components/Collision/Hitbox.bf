using System;
using System.Collections;

namespace Strawberry
{
	public class Hitbox : Component, IDebugDraw
	{
		public bool Collidable = true;
		public Rect Rect;

		public this(Rect rect)
		{
			Rect = rect;
		}

		public this(int x, int y, int width, int height)
		{
			Rect = .(x, y, width, height);
		}

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

		/*
			Edges
		*/

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

		public int CenterX
		{
			[Inline]
			get
			{
				return Entity.X + Rect.X + Rect.Width / 2;
			}

			[Inline]
			set
			{
				Entity.X = value - (Rect.X + Rect.Width / 2);
			}
		}

		public int CenterY
		{
			[Inline]
			get
			{
				return Entity.Y + Rect.Y + Rect.Height / 2;
			}

			[Inline]
			set
			{
				Entity.Y = value - (Rect.Y + Rect.Height / 2);
			}
		}

		/*
			Points
		*/

		public Point TopLeft
		{
			[Inline]
			get
			{
				return .(Left, Top);
			}

			[Inline]
			set
			{
				Left = value.X;
				Top = value.Y;
			}
		}

		public Point TopCenter
		{
			[Inline]
			get
			{
				return .(CenterX, Top);
			}

			[Inline]
			set
			{
				CenterX = value.X;
				Top = value.Y;
			}
		}

		public Point TopRight
		{
			[Inline]
			get
			{
				return .(Right, Top);
			}

			[Inline]
			set
			{
				Right = value.X;
				Top = value.Y;
			}
		}

		public Point CenterLeft
		{
			[Inline]
			get
			{
				return .(Left, CenterY);
			}

			[Inline]
			set
			{
				Left = value.X;
				CenterY = value.Y;
			}
		}

		public Point Center
		{
			[Inline]
			get
			{
				return .(CenterX, CenterY);
			}

			[Inline]
			set
			{
				CenterX = value.X;
				CenterY = value.Y;
			}
		}

		public Point CenterRight
		{
			[Inline]
			get
			{
				return .(Right, CenterY);
			}

			[Inline]
			set
			{
				Right = value.X;
				CenterY = value.Y;
			}
		}

		public Point BottomLeft
		{
			[Inline]
			get
			{
				return .(Left, Bottom);
			}

			[Inline]
			set
			{
				Left = value.X;
				Bottom = value.Y;
			}
		}

		public Point BottomCenter
		{
			[Inline]
			get
			{
				return .(CenterX, Bottom);
			}

			[Inline]
			set
			{
				CenterX = value.X;
				Bottom = value.Y;
			}
		}

		public Point BottomRight
		{
			[Inline]
			get
			{
				return .(Right, Bottom);
			}

			[Inline]
			set
			{
				Right = value.X;
				Bottom = value.Y;
			}
		}

		/*
			Single Collisions
		*/

		[Inline]
		public bool Check(Point point)
		{
			return SceneHitbox.Contains(point);
		}

		[Inline]
		public bool Check(Rect rect)
		{
			return SceneHitbox.Intersects(rect);
		}

		[Inline]
		public bool Check(Grid grid)
		{
			return grid != null && grid.Check(SceneHitbox);
		}

		[Inline]
		public bool Check(Grid grid, Point offset)
		{
			return grid != null && grid.Check(SceneHitbox + offset);
		}

		[Inline]
		public bool Check(Hitbox other)
		{
			return other.Collidable && SceneHitbox.Intersects(other.SceneHitbox);
		}

		[Inline]
		public bool Check(Hitbox other, Point offset)
		{
			return other.Collidable && (SceneHitbox + offset).Intersects(other.SceneHitbox);
		}

		[Inline]
		public bool CheckOutside(Hitbox other, Point offset)
		{
			return other.Collidable && !SceneHitbox.Intersects(other.SceneHitbox) && (SceneHitbox + offset).Intersects(other.SceneHitbox);
		}

		[Inline]
		public bool Check(IHasHitbox other)
		{
			return Check(other.Hitbox);
		}

		[Inline]
		public bool Check(IHasHitbox other, Point offset)
		{
			return Check(other.Hitbox, offset);
		}

		[Inline]
		public bool CheckOutside(IHasHitbox other, Point offset)
		{
			return CheckOutside(other.Hitbox, offset);
		}

		/*
			Type Collisions
		*/

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

		/*
			Type Collision w/ Conditions
		*/

		public bool Check<T>(delegate bool(T) condition) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (Check(e.Hitbox) && condition(e))
					return true;

			return false;
		}

		public bool Check<T>(Point offset, delegate bool(T) condition) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (Check(e.Hitbox, offset) && condition(e))
					return true;

			return false;
		}

		public bool CheckOutside<T>(Point offset, delegate bool(T) condition) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (CheckOutside(e.Hitbox, offset) && condition(e))
					return true;

			return false;
		}

		public T First<T>(delegate bool(T) condition) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (Check(e.Hitbox) && condition(e))
					return e;

			return null;
		}

		public T First<T>(Point offset, delegate bool(T) condition) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (Check(e.Hitbox, offset) && condition(e))
					return e;

			return null;
		}

		public T FirstOutside<T>(Point offset, delegate bool(T) condition) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (CheckOutside(e.Hitbox, offset) && condition(e))
					return e;

			return null;
		}

		public List<T> All<T>(List<T> into, delegate bool(T) condition) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (Check(e.Hitbox) && condition(e))
					into.Add(e);

			return into;
		}

		public List<T> All<T>(Point offset, List<T> into, delegate bool(T) condition) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (Check(e.Hitbox, offset) && condition(e))
					into.Add(e);

			return into;
		}

		public List<T> AllOutside<T>(Point offset, List<T> into, delegate bool(T) condition) where T : Component, IHasHitbox
		{
			for (var e in Scene.All<T>(scope List<T>()))
				if (CheckOutside(e.Hitbox, offset) && condition(e))
					into.Add(e);

			return into;
		}
	}
}
