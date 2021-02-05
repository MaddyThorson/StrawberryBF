using System.Collections;
using System;

namespace Strawberry
{
	public class Scene
	{
		public float TimeStarted { get; private set; }

		private List<Entity> entities;
		private HashSet<Entity> toRemove;
		private HashSet<Entity> toAdd;
		private Dictionary<Type, List<Component>> componentTracker;

		public this()
		{
			entities = new List<Entity>();
			toAdd = new HashSet<Entity>();
			toRemove = new HashSet<Entity>();

			componentTracker = new Dictionary<Type, List<Component>>();
			for (let type in Tracker.AssignmentLists.Keys)
				componentTracker.Add(type, new List<Component>());
			for (let type in Tracker.Interfaces)
				componentTracker.Add(type, new List<Component>());
		}

		public ~this()
		{
			for (var e in entities)
				if (e.DeleteOnRemove)
					delete e;
			delete entities;

			for (var e in toAdd)
				if (e.DeleteOnRemove)
					delete e;
			delete toAdd;

			delete toRemove;

			for (let list in componentTracker.Values)
				delete list;
			delete componentTracker;
		}

		public virtual void Started()
		{
			TimeStarted = Time.Elapsed;
		}

		public virtual void Update()
		{
			UpdateLists();

			
		}

		public virtual void Draw()
		{
			
		}

		public Entity Add(Entity e)
		{
			if (e.Scene == null)
				toAdd.Add(e);
			return e;
		}

		public Entity Remove(Entity e)
		{
			if (e.Scene == this)
				toRemove.Add(e);
			return e;
		}

		private void UpdateLists()
		{
			if (toRemove.Count > 0)
			{
				for (let e in toRemove)
				{
					entities.Remove(e);
					e.[Friend]Removed();
					if (e.DeleteOnRemove)
						delete e;
				}

				toRemove.Clear();
			}

			if (toAdd.Count > 0)
			{
				for (let e in toAdd)
				{
					entities.Add(e);
					e.[Friend]Added(this);
				}
			}

			for (let e in entities)
				e.[Friend]UpdateLists();

			if (toAdd.Count > 0)
			{
				for (let e in toAdd)
					e.Started();
				toAdd.Clear();
			}
		}

		// Tracking

		private void TrackComponent(Component c)
		{
			for (let t in Tracker.AssignmentLists[c.GetType()])
				componentTracker[t].Add(c);
		}

		private void UntrackComponent(Component c)
		{
			for (let t in Tracker.AssignmentLists[c.GetType()])
				componentTracker[t].Remove(c);
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

		/*
			Finding Components
		*/

		public int Count<T>() where T : Component
		{
			return componentTracker[typeof(T)].Count;
		}

		public bool Check<T>(Point point) where T : Component, IHasHitbox
		{
			for (T c in componentTracker[typeof(T)])
				if (c.Hitbox.Check(point))
					return true;
			return false;
		}

		public bool Check<T>(Rect rect) where T : Component, IHasHitbox
		{
			for (T c in componentTracker[typeof(T)])
				if (c.Hitbox.Check(rect))
					return true;
			return false;
		}

		public T First<T>() where T : Component, IHasHitbox
		{
			for (T c in componentTracker[typeof(T)])
				return c;
			return null;
		}

		public T First<T>(Point point) where T : Component, IHasHitbox
		{
			for (T c in componentTracker[typeof(T)])
				if (c.Hitbox.Check(point))
					return c as T;
			return null;
		}

		public T First<T>(Rect rect) where T : Component, IHasHitbox
		{
			for (T c in componentTracker[typeof(T)])
				if (c.Hitbox.Check(rect))
					return c as T;
			return null;
		}

		public List<T> All<T>(List<T> into) where T : Component, IHasHitbox
		{
			for (T c in componentTracker[typeof(T)])
				into.Add(c as T);
			return into;
		}

		public List<T> All<T>(Point point, List<T> into) where T : Component, IHasHitbox
		{
			for (T c in componentTracker[typeof(T)])
				if (c.Hitbox.Check(point))
					into.Add(c as T);
			return into;
		}

		public List<T> All<T>(Rect rect, List<T> into) where T : Component, IHasHitbox
		{
			for (T c in componentTracker[typeof(T)])
				if (c.Hitbox.Check(rect))
					into.Add(c as T);
			return into;
		}
	}
}
