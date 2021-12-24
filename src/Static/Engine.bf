using System;
namespace Strawberry
{
	static public class Engine
	{
		static public void Run(Module module)
		{
			Startup();

			Module currentModule = module;
			while (currentModule != null)
			{
				let newModule = currentModule.[Friend]Run();
				currentModule = newModule;
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
			Sprite.[Friend]Dispose();
		}
	}
}
