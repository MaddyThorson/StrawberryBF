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

	public abstract class Game : Module
	{
		public readonly List<VirtualInput> VirtualInputs;
		
		private Scene scene;
		private Scene switchToScene;
		private bool updating;

		public Batcher Batcher { get; private set; }
		public Color ClearColor = .Black;
		public bool DebugOverlay = false;

		private bool* keyboardState;
		private int32 updateCounter;
		private float msCounter;

		public this()
		{
			Game = this;

			Batcher = PlatformLayer.CreateBatcher();
			VirtualInputs = new List<VirtualInput>();
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
			delete Batcher;

			Game = null;
		}

		protected override void Update()
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
			}
		}

		protected override void Render()
		{
			PlatformLayer.GameRenderBegin();
			Draw();
			PlatformLayer.GameRenderEnd();

			if (DebugOverlay)
			{
				PlatformLayer.ImGuiRenderBegin();
				DebugOverlay();
				PlatformLayer.ImGuiRenderEnd();
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
