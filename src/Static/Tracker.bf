using System.Collections;
using System;
namespace Strawberry
{
	static public class Tracker
	{
		static public Dictionary<Type, List<Type>> AssignmentLists = new .() ~ DeleteDictionaryAndValues!(_);
		static public List<Type> Interfaces = new .() ~ delete _;

		static private void BuildAssignmentLists()
		{
			// Find all interfaces with ComponentInterfaceAttribute
			for (let type in Type.Enumerator())
				if (type.IsInterface && type.HasCustomAttribute<ComponentInterfaceAttribute>())
					Interfaces.Add(type);

			/*
				For each Type that extends Component, we build a list of all the tracked Interfaces it implements.
				We use these lists later to bucket Components as they are added to the Scene.
				This allows us to retrieve Components by their type or by any of their implemented interface types.
			*/

			for (let type in Type.Enumerator())
			{	
				if (type != typeof(Component) && type.IsSubtypeOf(typeof(Component)))
				{
					let list = new List<Type>();
					list.Add(type);
					for (let check in Interfaces)
						if (type.IsSubtypeOf(check))
							list.Add(check);

					AssignmentLists.Add(type, list);
				}
			}
		}
	}
}
