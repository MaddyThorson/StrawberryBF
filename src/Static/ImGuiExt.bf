using ImGui;

namespace ImGui
{
	extension ImGui
	{
		public extension Vec2
		{
			static public Vec2 operator+(Vec2 a, Vec2 b)
			{
				return .(a.x + b.x, a.y + b.y);
			}

			static public Vec2 operator-(Vec2 a, Vec2 b)
			{
				return .(a.x - b.x, a.y - b.y);
			}
		}

		static public bool BeginSplitter(char8* id, float percent, bool horizontal, float padding, bool enableFirst, bool enableSecond, WindowFlags flags)
		{
			PushID(id);

			// get bounds
			let p = GetCurrentWindow().DC.CursorPos;
			let s = GetContentRegionAvail();
			var rect = ImGui.Rect(p, p + s);
			let size = (horizontal ? rect.GetWidth() : rect.GetHeight());

			// get storage
			let storage = GetStateStorage();
			storage.SetBool(GetID("split-disable-first"), !enableFirst);
			storage.SetBool(GetID("split-disable-second"), !enableSecond);
			storage.SetBool(GetID("split-horizontal"), horizontal);
			storage.SetFloat(GetID("split-rect-min-x"), rect.Min.x);
			storage.SetFloat(GetID("split-rect-min-y"), rect.Min.y);
			storage.SetFloat(GetID("split-rect-max-x"), rect.Max.x);
			storage.SetFloat(GetID("split-rect-max-y"), rect.Max.y);

			// not enabled
			if (!enableFirst)
				return false;

			ImGui.Rect bounds;
			if (enableSecond)
			{
				let size1_id = GetID("split-percent-first");
				let size2_id = GetID("split-percent-second");

				// get size
				float percent1 = storage.GetFloat(size1_id, percent);
				float percent2 = storage.GetFloat(size2_id, (1.0f - percent));
				float size1 = size * percent1;
				float size2 = size * percent2;

				// make grabber
				ImGui.Rect bb;
				if (horizontal)
					bb = .(rect.Min.x + size1 - 1, rect.Min.y, rect.Min.x + size1 + 1, rect.Max.y);
				else
					bb = .(rect.Min.x, rect.Min.y + size1 - 1, rect.Max.x, rect.Min.y + size1 + 1);
				SplitterBehavior(bb, GetID("split-handle"), (horizontal ? Axis.X : Axis.Y), &size1, &size2, 29, 25, 4.0f);

				// set size
				storage.SetFloat(size1_id, size1 / size);
				storage.SetFloat(size2_id, size2 / size);

				bounds = .(rect.Min, (horizontal ? Vec2(rect.Min.x + size1, rect.Max.y) : Vec2(rect.Max.x, rect.Min.y + size1)));
			}
			else
			{
				bounds = rect;
			}

			SetNextWindowPos(bounds.Min);
			PushStyleVar(.WindowPadding, Vec2(padding, padding));
			PushStyleVar(.ChildRounding, 0);
			bool result = BeginChild("first", bounds.Max - bounds.Min, true, flags);
			PopStyleVar(2);
			return result;
		}

		static public bool MiddleSplitter(float padding, WindowFlags flags)
		{
			// first was disabled
			bool firstDisabled = true;
			if (!GetStateStorage().GetBool(GetID("split-disable-first")))
			{
				firstDisabled = false;
				EndChild();
			}

			// second is disabled
			if (GetStateStorage().GetBool(GetID("split-disable-second")))
				return false;

			// get the original full bounds
			ImGui.Rect rect;
			let storage = GetStateStorage();
			rect.Min.x = storage.GetFloat(GetID("split-rect-min-x"));
			rect.Min.y = storage.GetFloat(GetID("split-rect-min-y"));
			rect.Max.x = storage.GetFloat(GetID("split-rect-max-x"));
			rect.Max.y = storage.GetFloat(GetID("split-rect-max-y"));

			// get this side bounds
			ImGui.Rect bounds;
			if (firstDisabled)
			{
				bounds = rect;
			}
			else
			{
				let horizontal = storage.GetBool(GetID("split-horizontal"), true);
				let size2 = storage.GetFloat(GetID("split-percent-second")) * (horizontal ? rect.GetWidth() : rect.GetHeight());
				bounds = .((horizontal ? Vec2(rect.Max.x - size2, rect.Min.y) : Vec2(rect.Min.x, rect.Max.y - size2)), rect.Max);
			}

			SetNextWindowPos(bounds.Min);
			PushStyleVar(.WindowPadding, .(padding, padding));
			PushStyleVar(.ChildRounding, 0);
			bool result = BeginChild("second", bounds.Max - bounds.Min, true, flags);
			PopStyleVar(2);
			return result;
		}

		static public void EndSplitter()
		{
			if (!GetStateStorage().GetBool(GetID("split-disable-second")))
				EndChild();

			PopID();
		}
		
	}
}
