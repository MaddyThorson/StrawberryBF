using System.Collections;
using System;
using System.Reflection;

namespace Strawberry
{
	static public class Tracker
	{
		static public List<Type> Components = new .() ~ delete _;
		static public List<Type> Interfaces = new .() ~ delete _;
		static public Dictionary<Type, List<Type>> AssignmentLists = new .() ~ DeleteDictionaryAndValues!(_);

		static private void BuildAssignmentLists()
		{
			// Find all component types
			for (let type in Type.Types)
				if (type != typeof(Component) && type.IsSubtypeOf(typeof(Component)))
					Components.Add(type);

			// Find all interfaces with ComponentInterfaceAttribute
			for (let type in Type.Types)
			{
				if (type.IsInterface)
				{
					bool foundUse = false;

					Find: for (let c in Components)
					{
						for (let i in c.Interfaces)
						{
							if (i == type)
							{
								foundUse = true;
								break Find;
							}
						}
					}

					if (foundUse)
						Interfaces.Add(type);
				}
			}

			/*
				For each Type that extends Component, we build a list of all the tracked Interfaces it implements.
				We use these lists later to bucket Components as they are added to the Scene.
				This allows us to retrieve Components by their type or by any of their implemented interface types.
			*/

			for (let type in Components)
			{	
				let list = new List<Type>();
				list.Add(type);
				for (let int in type.Interfaces)
					if (Interfaces.Contains(int))
						list.Add(int);

				AssignmentLists.Add(type, list);
			}

			Calc.Log(scope => GetTrackedInterfacesInfo);
			Calc.Log(scope => GetTrackedTypesInfo);
		}

		static public void GetTrackedInterfacesInfo(String buffer)
		{
			buffer.Append("Tracked Interfaces:\n");
			for (int i = 0; i < Interfaces.Count; i++)
			{
				buffer.Append("-");
				Interfaces[i].GetName(buffer);
				if (i < Interfaces.Count - 1)
					buffer.Append('\n');
			}
		}

		static public void GetTrackedTypesInfo(String buffer)
		{
			buffer.Append("Tracked Types:\n");

			int index = 0;
			for (let kv in AssignmentLists)
			{
				buffer.Append("-");
				kv.key.GetName(buffer);
				buffer.Append(" as ");

				for (int i = 0; i < kv.value.Count; i++)
				{
					kv.value[i].GetName(buffer);
					if (i < kv.value.Count - 1)
						buffer.Append(", ");
				}

				index++;
				if (index < AssignmentLists.Count)
					buffer.Append('\n');
			}
		}
	}
}
