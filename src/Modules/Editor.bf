using ImGui;
namespace Strawberry
{
	public abstract class Editor : Module
	{

		protected override void Update()
		{

		}

		protected override void Render()
		{
			PlatformLayer.RenderBegin();
			PlatformLayer.ImGuiRenderBegin();
			ImGui.PushID("Editor");
			UI();
			ImGui.PopID();
			PlatformLayer.ImGuiRenderEnd();
			PlatformLayer.RenderEnd();
		}

		protected abstract void UI();
	}
}
