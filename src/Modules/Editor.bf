namespace Strawberry
{
	public abstract class Editor : Module
	{
		public this(PlatformLayer platformLayer)
			: base(platformLayer)
		{
			
		}

		protected override void Update()
		{

		}

		protected override void Render()
		{
			PlatformLayer.ImGuiRenderBegin();
			UI();
			PlatformLayer.ImGuiRenderEnd();
			PlatformLayer.RenderEnd();
		}

		protected abstract void UI();
	}
}
