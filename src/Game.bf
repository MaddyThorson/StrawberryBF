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
		
		private Scene scene;
		private Scene switchToScene;
		private bool updating;

		public SDL.Renderer* Renderer { get; private set; }
		public bool* KeyboardState { get; private set; }
		public bool* PreviousKeyboardState { get; private set; }

		private SDL.Rect screenRect;
		private SDL.Window* window;
		private SDL.Surface* screen;
		private int32 updateCounter;

		public this(String windowTitle, int32 width, int32 height)
			: base()
		{
			Game = this;
			VirtualInputs = new List<VirtualInput>();

			Title = windowTitle;
			Width = width;
			Height = height;

			screenRect = SDL.Rect(0, 0, width, height);
		}

		public ~this()
		{
			if (scene != null)
				delete scene;

			if (switchToScene != scene && switchToScene != null)
				delete switchToScene;

			delete VirtualInputs;

			Game = null;
		}

		public void Run()
		{
			Stopwatch sw = scope .();
			sw.Start();
			int curPhysTickCount = 0;

			while (true)
			{
				SDL.Event event;
				if (SDL.PollEvent(out event) != 0 && event.type == .Quit)
					return;

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
					PreviousKeyboardState = KeyboardState;
					KeyboardState = SDL.GetKeyboardState(null);

					addTicks = Math.Min(addTicks, 20); // Limit catchup
					if (addTicks > 0)
					{
						for (int i < addTicks)
						{
							updateCounter++;
							Update();
						}
						Render();
					}
					else
						Thread.Sleep(1);
				}

				curPhysTickCount = newPhysTickCount;
			}
		}

		public virtual void Init()
		{
			String exePath = scope .();
			Environment.GetExecutableFilePath(exePath);
			String exeDir = scope .();
			Path.GetDirectoryPath(exePath, exeDir);
			Directory.SetCurrentDirectory(exeDir);

			SDL.Init(.Video | .Events | .Audio);
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

			if (scene != null)
				scene.Update();

			Time.PreviousElapsed = Time.Elapsed;
			Time.Elapsed += Time.Delta;
		}

		public void Render()
		{
			SDL.SetRenderDrawColor(Renderer, 0, 0, 0, 255);
			SDL.RenderClear(Renderer);
			if (Scene != null)
				Scene.Draw();
			SDL.RenderPresent(Renderer);
		}

		public virtual void Draw()
		{
			
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
	}
}
