using System.Collections;
using System;

namespace Strawberry
{
	static public class TypeTree
	{
		static private Dictionary<Type, List<Type>> EntityAssignableLists;
		static private Dictionary<Type, List<Type>> ComponentAssignableLists;

		static private void Build()
		{
			/*
				For each Type that extends Entity, we build a list of all the other Entity Types that it is assignable to.
				We cache these lists, and use them later to bucket Entities as they are added to the Scene.
				This allows us to retrieve Entities by type very easily.
			*/

			EntityAssignableLists = new Dictionary<Type, List<Type>>();
			for (let type in Type.Enumerator())
			{	
				if (type != typeof(Entity) && type.IsSubtypeOf(typeof(Entity)))
				{
					let list = new List<Type>();
					for (let check in Type.Enumerator())
						if (check != typeof(Entity) && check.IsSubtypeOf(typeof(Entity)) && type.IsSubtypeOf(check))
							list.Add(check);
					EntityAssignableLists.Add(type, list);
				}
			}

			/*
				And then we also do this for components
			*/

			ComponentAssignableLists = new Dictionary<Type, List<Type>>();
			for (let type in Type.Enumerator())
			{	
				if (type != typeof(Component) && type.IsSubtypeOf(typeof(Component)))
				{
					let list = new List<Type>();
					for (let check in Type.Enumerator())
						if (check != typeof(Component) && check.IsSubtypeOf(typeof(Component)) && type.IsSubtypeOf(check))
							list.Add(check);
					ComponentAssignableLists.Add(type, list);
				}
			}
		}

		static private void Dispose()
		{
			for (let list in EntityAssignableLists.Values)
				delete list;
			delete EntityAssignableLists;

			for (let list in ComponentAssignableLists.Values)
				delete list;
			delete ComponentAssignableLists;
		}
	}
}
