using SDL2;
using System;
using System.Diagnostics;

namespace Strawberry.SDL2
{
	public class SDL2PlatformLayer : PlatformLayer
	{
		public int TransformMatrixLocation { get; private set; }
		public int TextureMatrixLocation { get; private set; }
		public bool TexturesEnableLinearFilter = false;
		public bool TexturesEnableEdgeClamping = false;

		private SDL.Window* window;
		private SDL.Surface* screen;
		private SDL.Rect screenRect;
		private SDL.Renderer* renderer;
		private Shader shader;
		private SDL.SDL_GameController*[] gamepads;
		private bool* keyboard;

		private SDL.SDL_GLContext glContext;
		private uint glProgram;

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

				//We need to activate this somehwere to make use of the alpha layer
				GL.glEnable(GL.GL_BLEND);
				GL.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE_MINUS_SRC_ALPHA);
				
				shader = new Shader(String[2] (
					// vertex shader
					"""
					#version 330
					uniform mat4 u_matrix;
					layout(location=0) in vec2 a_position;
					layout(location=1) in vec2 a_tex;
					layout(location=2) in vec4 a_color;
					layout(location=3) in vec3 a_type;
					out vec2 v_tex;
					out vec4 v_col;
					out vec3 v_type;
					void main(void)
					{
						gl_Position = u_matrix * vec4(a_position.xy, 0, 1);
						v_tex = a_tex;
						v_col = a_color;
						v_type = a_type;
					}
					""",

					// fragment shader
					"""
					#version 330
					uniform sampler2D u_texture;
					in vec2 v_tex;
					in vec4 v_col;
					in vec3 v_type;
					out vec4 o_color;
					void main(void)
					{
						vec4 color = texture(u_texture, v_tex);
						o_color =
							v_type.x * color * v_col + 
							v_type.y * color.a * v_col + 
							v_type.z * v_col;
					}
					"""));

				glProgram = GL.glCreateProgram();
				GL.glAttachShader(glProgram, shader.vertexHandle);
				GL.glAttachShader(glProgram, shader.fragmentHandle);
				GL.glLinkProgram(glProgram);

				TransformMatrixLocation = GL.glGetUniformLocation(glProgram, "u_matrix");
				TextureMatrixLocation = GL.glGetUniformLocation(glProgram, "u_texture");

				int32 logLen = 0;
				char8[1024] log;
				GL.glGetProgramInfoLog(glProgram, 1024, &logLen, &log);
				if (logLen > 0)
					Calc.Log(&log, logLen);
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

		public ~this()
		{
			delete gamepads;
			delete shader;

			GL.glDeleteProgram(glProgram);
			SDL.GL_DeleteContext(glContext);
			SDL.DestroyWindow(window);
			SDL.Quit();
		}

		static void* SdlGetProcAddress(StringView string)
		{
			return SDL.SDL_GL_GetProcAddress(string.ToScopeCStr!());
		}

		public override bool Closed()
		{
			SDL.Event event;
			return (SDL.PollEvent(out event) != 0 && event.type == .Quit);
		}

		public override uint32 Ticks => SDL.GetTicks();

		public override void RenderBegin()
		{
			GL.glBindFramebuffer(GL.GL_FRAMEBUFFER, 0);
			GL.glClearColor(Game.ClearColor.Rf, Game.ClearColor.Gf, Game.ClearColor.Bf, Game.ClearColor.Af);
			GL.glClear(GL.GL_COLOR_BUFFER_BIT | GL.GL_DEPTH_BUFFER_BIT);
			GL.glUseProgram(glProgram);
		}

		public override void RenderEnd()
		{
			GL.glUseProgram(0);
			GL.glFlush();
			SDL.GL_SwapWindow(window);
		}

		public override Batcher CreateBatcher()
		{
			return new SDL2Batcher(this);
		}

		public override Texture LoadTexture(String path)
		{
			let surface = SDLImage.Load(path);
			Debug.Assert(surface != null, "Could not load from path.");
			Debug.Assert(surface.format.bytesPerPixel == 4, "Surface format incorrect.");

			var tex = new Texture(surface.w, surface.h, (uint8*)surface.pixels, TexturesEnableLinearFilter, TexturesEnableEdgeClamping);
			SDL.FreeSurface(surface);

			return tex;
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
