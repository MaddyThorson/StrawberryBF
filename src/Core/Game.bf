using SDL2;
using System;
using System.Collections;
using System.Reflection;
using System.IO;
using System.Diagnostics;
using System.Threading;

namespace Strawberry
{
	static
	{
		static public Game Game;
	}

	public class Game
	{
		public readonly List<VirtualInput> VirtualInputs;
		public readonly String Title;
		public readonly int Width;
		public readonly int Height;
		public readonly int WindowScale;
		public readonly int GamepadLimit;
		
		private Scene scene;
		private Scene switchToScene;
		private bool updating;
		private Dictionary<Type, List<Type>> entityAssignableLists;
		private Dictionary<Type, List<Type>> componentAssignableLists;

		public PlatformLayer PlatformLayer { get; private set; }
		public Color ClearColor = .Black;

		private bool* keyboardState;
		private int32 updateCounter;

		public this(PlatformLayer platformLayer, String windowTitle, int32 width, int32 height, int32 windowScale, int gamepadLimit)
			: base()
		{
			Game = this;
			PlatformLayer = platformLayer;

			Title = windowTitle;
			Width = width;
			Height = height;
			WindowScale = windowScale;
			GamepadLimit = gamepadLimit;

			String exePath = scope .();
			Environment.GetExecutableFilePath(exePath);
			String exeDir = scope .();
			Path.GetDirectoryPath(exePath, exeDir);
			Directory.SetCurrentDirectory(exeDir);

			platformLayer.Init();

			VirtualInputs = new List<VirtualInput>();
			Input.[Friend]Init();

			BuildTypeLists();
			Assets.LoadAll();
			Strawberry.Console.Init();
		}

		public ~this()
		{
			if (scene != null)
				delete scene;

			if (switchToScene != scene && switchToScene != null)
				delete switchToScene;

			{
				let list = scope List<VirtualInput>();
				for (var i in VirtualInputs)
					list.Add(i);
				for (var i in list)
					delete i;
				delete VirtualInputs;
			}

			Assets.DisposeAll();
			DisposeTypeLists();
			Input.[Friend]Dispose();
			Strawberry.Console.Dispose();
			Game = null;
		}

		public void Run()
		{
			float msCounter = 0;
			uint32 prevTick = 0;
			while (true)
			{
				if (PlatformLayer.Closed())
					return;

				uint32 tick = PlatformLayer.Ticks;
				msCounter += (tick - prevTick);
				prevTick = tick;

				if (Time.FixedTimestep)
				{
					Time.RawDelta = Time.TargetDeltaTime;
					while (msCounter >= Time.TargetMilliseconds)
					{
						msCounter -= Time.TargetMilliseconds;
						PlatformLayer.UpdateInput();
						Update();
						Input.AfterUpdate();
					}
				}
				else
				{
					Time.RawDelta = msCounter / 1000;
					PlatformLayer.UpdateInput();
					Update();
					Input.AfterUpdate();
				}

				Render();
			}
		}

		public virtual void Update()
		{
			//Input
			for (var i in VirtualInputs)
				i.Update();

			//Switch scenes
			if (switchToScene != scene)
			{
				if (scene != null)
					delete scene;
				scene = switchToScene;
				scene.Started();
			}

			if (Time.Freeze > 0)
				Time.Freeze -= Time.RawDelta;
			else
			{
				if (scene != null)
					scene.Update();

				Time.RawPreviousElapsed = Time.RawElapsed;
				Time.RawElapsed += Time.RawDelta;

				Time.PreviousElapsed = Time.Elapsed;
				Time.Elapsed += Time.Delta;
			}

			Strawberry.Console.[Friend]Update();
		}

		private void Render()
		{
			PlatformLayer.RenderBegin();
			//Draw();
			PlatformLayer.RenderEnd();
		}

		public virtual void Draw()
		{
			if (Scene != null)
			{
				Draw.PushCamera(Scene.Camera.Round());
				Scene.Draw();
				Draw.PopCamera();
			}

			if (Console.Enabled)
				Strawberry.Console.[Friend]Draw();
		}

		public Scene Scene
		{
			get
			{
				return scene;
			}

			set
			{
				if (switchToScene != scene && switchToScene != null)
					delete switchToScene;
				switchToScene = value;
			}
		}

		// Type assignable caching

		private void BuildTypeLists()
		{
			/*
				For each Type that extends Entity, we build a list of all the other Entity Types that it is assignable to.
				We cache these lists, and use them later to bucket Entities as they are added to the Scene.
				This allows us to retrieve Entities by type very easily.
			*/

			entityAssignableLists = new Dictionary<Type, List<Type>>();
			for (let type in Type.Enumerator())
			{	
				if (type != typeof(Entity) && type.IsSubtypeOf(typeof(Entity)))
				{
					let list = new List<Type>();
					for (let check in Type.Enumerator())
						if (check != typeof(Entity) && check.IsSubtypeOf(typeof(Entity)) && type.IsSubtypeOf(check))
							list.Add(check);
					entityAssignableLists.Add(type, list);
				}
			}

			/*
				And then we also do this for components
			*/

			componentAssignableLists = new Dictionary<Type, List<Type>>();
			for (let type in Type.Enumerator())
			{	
				if (type != typeof(Component) && type.IsSubtypeOf(typeof(Component)))
				{
					let list = new List<Type>();
					for (let check in Type.Enumerator())
						if (check != typeof(Component) && check.IsSubtypeOf(typeof(Component)) && type.IsSubtypeOf(check))
							list.Add(check);
					componentAssignableLists.Add(type, list);
				}
			}
		}

		private void DisposeTypeLists()
		{
			for (let list in entityAssignableLists.Values)
				delete list;
			delete entityAssignableLists;

			for (let list in componentAssignableLists.Values)
				delete list;
			delete componentAssignableLists;
		}
	}
}
