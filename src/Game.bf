using SDL2;
using System;
using System.Collections;

namespace Strawberry
{
	static
	{
		static public Game Game;
	}

	public class Game : SDLApp
	{
		public List<VirtualInput> VirtualInputs;
		public float DeltaTime { get; private set; }
		public float Time { get; private set; }
		public float PreviousTime { get; private set; }

		private Scene scene;
		private Scene switchToScene;
		private bool updating;
		private SDL.Rect screenRect;

		public this(String windowTitle, int32 width, int32 height)
			: base()
		{
			Game = this;
			VirtualInputs = new List<VirtualInput>();
			DeltaTime = 1 / 60f;

			mTitle.Set(windowTitle);
			mWidth = width;
			mHeight = height;

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

		public new virtual void Init()
		{
			base.Init();
		}

		public override void Update()
		{
			base.Update();

			//Switch scenes
			if (switchToScene != scene)
			{
				if (scene != null)
					delete scene;
				scene = switchToScene;
				scene.Started();
			}

			for (var i in VirtualInputs)
				i.Update();

			if (scene != null)
				scene.Update();

			PreviousTime = Time;
			Time += DeltaTime;
		}

		public override void Draw()
		{
			base.Draw();

			SDL2.SDL.SetRenderDrawColor(mRenderer, 0, 0, 0, 255);
			SDL2.SDL.RenderFillRect(mRenderer, &screenRect);

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
	}
}
