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
		
		private Scene scene;
		private Scene switchToScene;
		private bool updating;

		public SDL.Renderer* Renderer { get; private set; }

		private SDL.Rect screenRect;
		private SDL.Window* window;
		private SDL.Surface* screen;
		private bool* keyboardState;
		private SDL.SDL_GameController*[] gamepads;
		private int32 updateCounter;

		public this(String windowTitle, int32 width, int32 height, int32 windowScale, int gamepadLimit = 1)
			: base()
		{
			Game = this;
			VirtualInputs = new List<VirtualInput>();

			Title = windowTitle;
			Width = width;
			Height = height;
			WindowScale = windowScale;

			screenRect = SDL.Rect(0, 0, width * windowScale, height * windowScale);

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

			this.gamepads = new SDL.SDL_GameController*[gamepadLimit];
			for (let i < this.gamepads.Count)
				this.gamepads[i] = SDL.GameControllerOpen((int32)i);
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

			delete gamepads;
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
					keyboardState = SDL.GetKeyboardState(null);
					SDL.GameControllerUpdate();

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
		}

		public void Render()
		{
			SDL.SetRenderDrawColor(Renderer, 0, 0, 0, 255);
			SDL.RenderClear(Renderer);
			SDL.RenderSetScale(Renderer, WindowScale, WindowScale);
			Draw();
			SDL.RenderPresent(Renderer);
		}

		public virtual void Draw()
		{
			if (Scene != null)
				Scene.Draw();
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

		// Input

		public bool KeyCheck(SDL.Scancode key)
		{
			if (keyboardState == null)
				return false;
			return keyboardState[(int)key];
		}

		public bool GamepadButtonCheck(int gamepadID, SDL.SDL_GameControllerButton button)
		{
			if (gamepads == null)
				return false;
			return SDL.GameControllerGetButton(gamepads[gamepadID], button) == 1;
		}

		public float GamepadAxisCheck(int gamepadID, SDL.SDL_GameControllerAxis axis)
		{
			if (gamepads == null)
				return 0;

			let val = SDL.GameControllerGetAxis(gamepads[gamepadID], axis);
			if (val == 0)
				return 0;
			else if (val > 0)
				return val / 32767f;
			else
				return val / 32768f;
		}
	}
}
