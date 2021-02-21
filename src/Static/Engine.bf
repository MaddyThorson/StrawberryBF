using System;
namespace Strawberry
{
	static public class Engine
	{
		static public void Run(Module module)
		{
			Startup();

			Module current = module;
			current.[Friend]Started();
			while (true)
			{
				let newModule = current.Run();

				if (newModule != null)
				{
					delete current;
					current = newModule;
					current.[Friend]Started();
				}
				else
				{
					delete current;
					break;
				}
			}

			Shutdown();
		}

		static private void Startup()
		{
			Input.[Friend]Startup();
			Tracker.[Friend]BuildAssignmentLists();
		}

		static private void Shutdown()
		{
			Input.[Friend]Shutdown();
		}
	}
}
