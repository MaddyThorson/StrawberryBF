using SDL2;
using System;
using System.Diagnostics;

namespace Strawberry
{
	public class SDL2PlatformLayer : PlatformLayer
	{
		private SDL.Window* window;
		private SDL.Surface* screen;
		private SDL.Rect screenRect;
		private SDL.Renderer* renderer;
		private SDL.SDL_GLContext glContext;
		private uint glProgram;
		private SDL.SDL_GameController*[] gamepads;
		private bool* keyboard;

		public override void Init()
		{
			SDL.Version version;
			SDL.GetVersion(out version);
			Calc.Log("Init SDL Version {0}.{1}.{2}", version.major, version.minor, version.patch);

			{
				SDL.InitFlag init = .Video | .Events | .Audio | .Timer;
				if (Game.GamepadLimit > 0)
					init |= .GameController;
	
				if (SDL.Init(init) != 0)
					Runtime.FatalError("Failed to initialize SDL");
			}

			SDL.EventState(.JoyAxisMotion, .Disable);
			SDL.EventState(.JoyBallMotion, .Disable);
			SDL.EventState(.JoyHatMotion, .Disable);
			SDL.EventState(.JoyButtonDown, .Disable);
			SDL.EventState(.JoyButtonUp, .Disable);
			SDL.EventState(.JoyDeviceAdded, .Disable);
			SDL.EventState(.JoyDeviceRemoved, .Disable);

			//Graphics
			{
				screenRect = SDL.Rect(0, 0, (int32)(Game.Width * Game.WindowScale), (int32)(Game.Height * Game.WindowScale));
				window = SDL.CreateWindow(Game.Title, .Centered, .Centered, screenRect.w, screenRect.h, .Shown | .OpenGL);
				renderer = SDL.CreateRenderer(window, -1, .Accelerated);
				screen = SDL.GetWindowSurface(window);
				SDLImage.Init(.PNG | .JPG);
				SDLTTF.Init();

				glContext = SDL.GL_CreateContext(window);
				SDL.GL_SetSwapInterval(1);
				GL.Init(=> SdlGetProcAddress);

				glProgram = GL.glCreateProgram();
			}

			//Audio
			{
				SDLMixer.OpenAudio(44100, SDLMixer.MIX_DEFAULT_FORMAT, 2, 4096);
			}
			
			//Input
			{
				keyboard = SDL.GetKeyboardState(null);
				gamepads = new SDL.SDL_GameController*[Game.GamepadLimit];
				for (let i < gamepads.Count)
					gamepads[i] = SDL.GameControllerOpen((int32)i);
			}
		}

		static void* SdlGetProcAddress(StringView string)
		{
			return SDL.SDL_GL_GetProcAddress(string.ToScopeCStr!());
		}

		public ~this()
		{
			delete gamepads;

			GL.glDeleteProgram(glProgram);
			SDL.GL_DeleteContext(glContext);
			SDL.DestroyWindow(window);
			SDL.Quit();
		}

		public override bool Closed()
		{
			SDL.Event event;
			return (SDL.PollEvent(out event) != 0 && event.type == .Quit);
		}

		public override uint32 Ticks => SDL.GetTicks();

		public override void RenderBegin()
		{
			GL.glClearColor(Game.ClearColor.Rf, Game.ClearColor.Gf, Game.ClearColor.Bf, Game.ClearColor.Af);
			GL.glClear(GL.GL_COLOR_BUFFER_BIT);
			GL.glCreateProgram();
		}

		public override void RenderEnd()
		{
			SDL.GL_SwapWindow(window);
		}

		public override void UpdateInput()
		{
			SDL.PumpEvents();
			SDL.GameControllerUpdate();
		}

		public override bool PollKey(Keys key)
		{
			Debug.Assert(keyboard != null, "Polling keyboard before initialized");

			return keyboard[(uint32)key];
		}

		public override bool CapsLock => SDL.GetModState() & .Caps > 0;
		public override bool NumLock => SDL.GetModState() & .Num > 0;

		public override bool PollGamepadButton(int gamepadID, Buttons button)
		{
			Debug.Assert(gamepads != null, "Polling gamepad before initialized");
			Debug.Assert(gamepadID >= 0 && gamepadID < gamepads.Count, "Gamepad index out of range (increase Game.gamepadLimit?)");

			return SDL.GameControllerGetButton(gamepads[gamepadID], (SDL.SDL_GameControllerButton)button) == 1;
		}

		public override float PollGamepadAxis(int gamepadID, Axes axis)
		{
			Debug.Assert(gamepads != null, "Polling gamepad before initialized");
			Debug.Assert(gamepadID >= 0 && gamepadID < gamepads.Count, "Gamepad index out of range (increase Game.gamepadLimit?)");

			let val = SDL.GameControllerGetAxis(gamepads[gamepadID], (SDL.SDL_GameControllerAxis)axis);
			if (val == 0)
				return 0;
			else if (val > 0)
				return val / 32767f;
			else
				return val / 32768f;
		}
	}
}
