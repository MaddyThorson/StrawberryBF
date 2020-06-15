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
		public readonly String ContentRoot;
		
		private Scene scene;
		private Scene switchToScene;
		private bool updating;
		private Dictionary<Type, List<Type>> entityAssignableLists;
		private Dictionary<Type, List<Type>> componentAssignableLists;

		//SDL Vars
		public SDL.Renderer* Renderer { get; private set; }
		public Color ClearColor = .Black;

		private SDL.Rect screenRect;
		private SDL.Window* window;
		private SDL.Surface* screen;
		private bool* keyboardState;
		private int32 updateCounter;

		public this(String windowTitle, int32 width, int32 height, int32 windowScale, int gamepadLimit = 1)
			: base()
		{
			Game = this;

			Title = windowTitle;
			Width = width;
			Height = height;
			WindowScale = windowScale;
			screenRect = SDL.Rect(0, 0, width * windowScale, height * windowScale);

#if DEBUG
			ContentRoot = "../../../src/Content/";
#else
			ContentRoot = "Content/";
#endif

			String exePath = scope .();
			Environment.GetExecutableFilePath(exePath);
			String exeDir = scope .();
			Path.GetDirectoryPath(exePath, exeDir);
			Directory.SetCurrentDirectory(exeDir);

			SDL.InitFlag init = .Video | .Events | .Audio;
			if (gamepadLimit > 0)
				init |= .GameController;
			SDL.Init(init);
			SDL.EventState(.JoyAxisMotion, .Disable);
			SDL.EventState(.JoyBallMotion, .Disable);
			SDL.EventState(.JoyHatMotion, .Disable);
			SDL.EventState(.JoyButtonDown, .Disable);
			SDL.EventState(.JoyButtonUp, .Disable);
			SDL.EventState(.JoyDeviceAdded, .Disable);
			SDL.EventState(.JoyDeviceRemoved, .Disable);

			window = SDL.CreateWindow(Title, .Centered, .Centered, screenRect.w, screenRect.h, .Shown);
			Renderer = SDL.CreateRenderer(window, -1, .Accelerated);
			screen = SDL.GetWindowSurface(window);
			SDLImage.Init(.PNG | .JPG);
			SDLMixer.OpenAudio(44100, SDLMixer.MIX_DEFAULT_FORMAT, 2, 4096);
			SDLTTF.Init();

			VirtualInputs = new List<VirtualInput>();
			Input.[Friend]Init(gamepadLimit);

			BuildTypeLists();
			Assets.LoadAll();
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
			Game = null;
		}

		public void Run()
		{
			Stopwatch sw = scope .();
			sw.Start();
			int curPhysTickCount = 0;

			/*
				Game loop adapted from Brian Fiete's SDLApp.bf in the Beef SDL2 Library
			*/

			while (true)
			{
				SDL.Event event;
				if (SDL.PollEvent(out event) != 0 && event.type == .Quit)
				{
					return;
				}

				// Fixed 60 Hz update
				double msPerTick = 1000 / 60.0;
				int newPhysTickCount = (int)(sw.ElapsedMilliseconds / msPerTick);

				int addTicks = newPhysTickCount - curPhysTickCount;
				if (curPhysTickCount == 0)
				{
					// Initial render
					Render();
				}
				else
				{
					addTicks = Math.Min(addTicks, 20); // Limit catchup
					if (addTicks > 0)
					{
						for (int i < addTicks)
						{
							Input.BeforeUpdate();
							updateCounter++;
							Update();
							Input.AfterUpdate();
						}
						Render();
					}
					else
						Thread.Sleep(1);
				}

				curPhysTickCount = newPhysTickCount;
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

				Time.PreviousElapsed = Time.Elapsed;
				Time.Elapsed += Time.Delta;
			}

			Strawberry.Console.Update();
		}

		private void Render()
		{
			SDL.SetRenderDrawColor(Renderer, ClearColor.R, ClearColor.G, ClearColor.B, ClearColor.A);
			SDL.RenderClear(Renderer);
			SDL.RenderSetScale(Renderer, WindowScale, WindowScale);
			Draw();
			SDL.RenderPresent(Renderer);
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
				Strawberry.Console.Draw();
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
