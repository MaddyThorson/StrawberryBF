using SDL2;
using System;
using System.Collections;
using System.Reflection;
using System.IO;
using System.Diagnostics;
using System.Threading;
using ImGui;

namespace Strawberry
{
	static
	{
		static public Game Game;
	}

	public abstract class Game
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

		public PlatformLayer PlatformLayer { get; private set; }
		public Batcher Batcher { get; private set; }
		public Color ClearColor = .Black;
		public bool DebugOverlay = false;

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

			platformLayer.UpdateScreenMatrix();
			platformLayer.Init();
			Batcher = platformLayer.CreateBatcher();

			VirtualInputs = new List<VirtualInput>();
			Input.[Friend]Init();

			Tracker.[Friend]BuildAssignmentLists();
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
			Input.[Friend]Dispose();

			delete Batcher;

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
					Time.RawDelta = (tick - prevTick) / 1000f;
					PlatformLayer.UpdateInput();
					Update();
					Input.AfterUpdate();
				}

				Render();
				prevTick = tick;
			}
		}

		public virtual void Update()
		{
			//Input
			for (var i in VirtualInputs)
				i.Update();

			//Debug Overlay
			if (Input.KeyPressed(.Grave))
				DebugOverlay = !DebugOverlay;

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
		}

		private void Render()
		{
			PlatformLayer.GameRenderBegin();
			Draw();
			PlatformLayer.GameRenderEnd();

			if (DebugOverlay)
			{
				PlatformLayer.EditorRenderBegin();
				DebugOverlay();
				PlatformLayer.EditorRenderEnd();
			}

			PlatformLayer.RenderEnd();
		}

		public virtual void Draw()
		{
			Scene?.Draw();
			Batcher.Draw();
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

		public virtual void DebugOverlay()
		{

		}
	}
}
