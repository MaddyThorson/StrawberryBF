using System;
using System.Collections;

namespace Strawberry
{
	public sealed class Entity
	{
		public Scene Scene { get; private set; }
		public bool IsAwake { get; private set; }
		public bool DeleteOnRemove = true;

		private List<Component> components = new List<Component>() ~ delete _;
		private HashSet<Component> toAdd = new HashSet<Component>() ~ delete _;
		private HashSet<Component> toRemove = new HashSet<Component>() ~ delete _;

		public this(Point position)
		{
			Positionf = position;
		}

		public ~this()
		{
			for (var c in components)
				delete c;
			for (var c in toAdd)
				delete c;
		}

		private void Added(Scene scene)
		{
			Scene = scene;
		}

		private void Removed()
		{
			for (var c in components)
			{
				c.End();
				c.[Friend]IsAwake = false;
				Scene.[Friend]UntrackComponent(c);
			}
			Scene = null;
			IsAwake = false;
		}

		private void AwakeCheck()
		{
			for (var c in components)
			{
				if (!c.[Friend]IsAwake)
				{
					c.Awake();
					c.[Friend]IsAwake = true;
				}
			}

			IsAwake = true;
		}

		[Inline]
		public void Destroy()
		{
			Scene?.Remove(this);
		}

		/*
			Components
		*/

		public T First<T>() where T : Component
		{
			for (let c in components)
				if (c is T)
					return c as T;
			return null;
		}

		public ICollection<T> All<T>(ICollection<T> into) where T : Component
		{
			for (let c in components)
				if (c is T)
					into.Add(c as T);
			return into;
		}

		public T Add<T>(T component) where T : Component
		{
			if (component.Entity == null)
				toAdd.Add(component);
			return component;
		}

		public T Remove<T>(T component) where T : Component
		{
			if (component.Entity == this)
				toRemove.Add(component);
			return component;
		}

		private void UpdateLists()
		{
			if (toRemove.Count > 0)
			{
				for (var c in toRemove)
				{
					components.Remove(c);
					Scene.[Friend]UntrackComponent(c);
					c.[Friend]Entity = null;
					delete c;
				}

				toRemove.Clear();
			}

			if (toAdd.Count > 0)
			{
				for (var c in toAdd)
				{
					components.Add(c);
					Scene.[Friend]TrackComponent(c);
					c.[Friend]Entity = this;
					c.Added();
				}

				if (IsAwake)
				{
					for (var c in toAdd)
					{
						c.Awake();
						c.[Friend]IsAwake = true;
					}
				}

				toAdd.Clear();
			}
		}

		/*
			Position
		*/

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
				return Calc.RoundToInt(Positionf.X);
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
				return Calc.RoundToInt(Positionf.Y);
			}

			[Inline]
			set
			{
				Positionf.Y = value;
			}
		}

		// ===== Misc =====

		[Inline]
		public T SceneAs<T>() where T : Scene
		{
			Runtime.Assert(Scene is T, "Scene type mismatch!");
			return Scene as T;
		}
	}
}
