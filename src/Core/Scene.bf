using System.Collections;
using System;

namespace Strawberry
{
	public class Scene
	{
		public float TimeStarted { get; private set; }
		public Rect Bounds;

		private List<Entity> entities;
		private HashSet<Entity> toRemove;
		private HashSet<Entity> toAdd;
		private Dictionary<Type, List<Entity>> entityTracker;
		private Dictionary<Type, List<Component>> componentTracker;

		public this()
		{
			entities = new List<Entity>();
			toAdd = new HashSet<Entity>();
			toRemove = new HashSet<Entity>();

			entityTracker = new Dictionary<Type, List<Entity>>();
			for (let type in Game.[Friend]entityAssignableLists.Keys)
				entityTracker.Add(type, new List<Entity>());

			componentTracker = new Dictionary<Type, List<Component>>();
			for (let type in Game.[Friend]componentAssignableLists.Keys)
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

			for (let list in entityTracker.Values)
				delete list;
			delete entityTracker;

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
			for (let e in entities)
				if (e.Active)
					e.Update();
		}

		public virtual void Draw()
		{
			for (let e in entities)
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
				for (let e in toRemove)
				{
					entities.Remove(e);
					UntrackEntity(e);
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
					TrackEntity(e);
					e.[Friend]Added(this);
				}

				entities.Sort(scope => Entity.Compare);
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

		private void TrackEntity(Entity e)
		{
			for (let t in Game.[Friend]entityAssignableLists[e.GetType()])
				entityTracker[t].Add(e);

			for (let c in e.[Friend]components)
				TrackComponent(c);
		}

		private void UntrackEntity(Entity e)
		{
			for (let t in Game.[Friend]entityAssignableLists[e.GetType()])
				entityTracker[t].Remove(e);

			for (let c in e.[Friend]components)
				UntrackComponent(c);
		}

		private void TrackComponent(Component c)
		{
			for (let t in Game.[Friend]componentAssignableLists[c.GetType()])
				componentTracker[t].Add(c);
		}

		private void UntrackComponent(Component c)
		{
			for (let t in Game.[Friend]componentAssignableLists[c.GetType()])
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

		// Finding Entities

		public int Count<T>() where T : Entity
		{
			return entityTracker[typeof(T)].Count;
		}

		public bool Check<T>(Point point) where T : Entity
		{
			for (let e in entityTracker[typeof(T)])
				if (e.Check(point))
					return true;
			return false;
		}

		public bool Check<T>(Rect rect) where T : Entity
		{
			for (let e in entityTracker[typeof(T)])
				if (e.Check(rect))
					return true;
			return false;
		}

		public T First<T>() where T : Entity
		{
			for (let e in entityTracker[typeof(T)])
				return e as T;
			return null;
		}

		public T First<T>(Point point) where T : Entity
		{
			for (let e in entityTracker[typeof(T)])
				if (e.Check(point))
					return e as T;
			return null;
		}

		public T First<T>(Rect rect) where T : Entity
		{
			for (let e in entityTracker[typeof(T)])
				if (e.Check(rect))
					return e as T;
			return null;
		}

		public List<T> All<T>(List<T> into) where T : Entity
		{
			for (let e in entityTracker[typeof(T)])
				into.Add(e as T);
			return into;
		}

		public List<T> All<T>(Point point, List<T> into) where T : Entity
		{
			for (let e in entityTracker[typeof(T)])
				if (e.Check(point))
					into.Add(e as T);
			return into;
		}

		public List<T> All<T>(Rect rect, List<T> into) where T : Entity
		{
			for (let e in entityTracker[typeof(T)])
				if (e.Check(rect))
					into.Add(e as T);
			return into;
		}

		/*
			Finding Components
		*/

		public int Count<T>() where T : Component
		{
			return componentTracker[typeof(T)].Count;
		}

		public List<T> All<T>(List<T> into) where T : Component
		{
			for (let c in componentTracker[typeof(T)])
				into.Add(c as T);
			return into;
		}

		public List<T> All<T>(Point point, List<T> into) where T : Component
		{
			for (let c in componentTracker[typeof(T)])
				if (c.Entity.Check(point))
					into.Add(c as T);
			return into;
		}

		public List<T> All<T>(Rect rect, List<T> into) where T : Component
		{
			for (let c in componentTracker[typeof(T)])
				if (c.Entity.Check(rect))
					into.Add(c as T);
			return into;
		}
	}
}
