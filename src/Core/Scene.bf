using System.Collections;
using System;

namespace Strawberry
{
	public class Scene
	{
		public float TimeStarted { get; private set; }
		public Grid SolidGrid;
		public Rect Bounds;

		private List<Entity> entities;
		private HashSet<Entity> toRemove;
		private HashSet<Entity> toAdd;

		public this()
		{
			entities = new List<Entity>();
			toAdd = new HashSet<Entity>();
			toRemove = new HashSet<Entity>();
		}

		public ~this()
		{
			if (SolidGrid != null)
				delete SolidGrid;

			for (var e in entities)
				if (e.DeleteOnRemove)
					delete e;
			delete entities;

			for (var e in toAdd)
				if (e.DeleteOnRemove)
					delete e;
			delete toAdd;

			delete toRemove;
		}

		public virtual void Started()
		{
			TimeStarted = Time.Elapsed;
		}

		public virtual void Update()
		{
			UpdateLists();
			for (var e in entities)
				if (e.Active)
					e.Update();
		}

		public virtual void Draw()
		{
			for (var e in entities)
				if (e.Visible)
					e.Draw();
		}

		public T Add<T>(T e) where T : Entity
		{
			if (e.Scene == null)
				toAdd.Add(e);
			return e;
		}

		public T Remove<T>(T e) where T : Entity
		{
			if (e.Scene == this)
				toRemove.Add(e);
			return e;
		}

		private void UpdateLists()
		{
			if (toRemove.Count > 0)
			{
				for (var e in toRemove)
				{
					entities.Remove(e);
					e.Removed();
					if (e.DeleteOnRemove)
						delete e;
				}

				toRemove.Clear();
			}

			if (toAdd.Count > 0)
			{
				for (var e in toAdd)
				{
					entities.Add(e);
					e.Added(this);
				}
			}

			for (var e in entities)
				e.UpdateLists();

			if (toAdd.Count > 0)
			{
				for (var e in toAdd)
					e.Started();

				toAdd.Clear();
			}
		}

		// Time

		public float TimeElapsed =>	Time.Elapsed - TimeStarted;
		public float PreviousTimeElapsed =>	Time.PreviousElapsed - TimeStarted;

		public bool TimeOnInterval(float interval, float offset = 0)
		{
			return (int)((TimeElapsed - offset) / interval) != (int)((PreviousTimeElapsed - offset) / interval);
		}

		public bool TimeBetweenInterval(float interval, float offset = 0)
		{
			return (TimeElapsed - offset) % (interval * 2) >= interval;
		}

		// Finding Entities

		public T First<T>() where T : Entity
		{
			for (var e in entities)
				if (e is T)
					return e as T;
			return null;
		}

		public T First<T>(Point point) where T : Entity
		{
			for (var e in entities)
				if (e is T && e.Check(point))
					return e as T;
			return null;
		}

		public T First<T>(Rect rect) where T : Entity
		{
			for (var e in entities)
				if (e is T && e.Check(rect))
					return e as T;
			return null;
		}

		public List<T> All<T>(List<T> into) where T : Entity
		{
			for (var e in entities)
				if (e is T)
					into.Add(e as T);
			return into;
		}

		public List<T> All<T>(Point point, List<T> into) where T : Entity
		{
			for (var e in entities)
				if (e is T && e.Check(point))
					into.Add(e as T);
			return into;
		}

		public List<T> All<T>(Rect rect, List<T> into) where T : Entity
		{
			for (var e in entities)
				if (e is T && e.Check(rect))
					into.Add(e as T);
			return into;
		}
	}
}
