using System.Collections;
using System;

namespace Strawberry
{
	public class VirtualAxis : VirtualInput
	{
		public enum OverlapBehaviors { TakeNewer, TakeOlder, CancelOut }

		public float Value { get; private set; }
		public int IntValue { get; private set; }
		public bool Pressed { get; private set; }
		public bool Released { get; private set; }
		public bool Repeating { get; private set; }

		private List<Node> nodes;
		private float pressBuffer;
		private float releaseBuffer;
		private float repeatStart;
		private float repeatInterval;

		private float lastPress;
		private float lastRelease;
		private float lastPressClear;
		private float lastReleaseClear;

		public this()
		{
			nodes = new List<Node>();
		}

		public ~this()
		{
			for (var n in nodes)
				delete n;
			delete nodes;
		}

		public override void Update()
		{
			for (var n in nodes)
				n.Update();

			//Value
			let last = IntValue;
			Value = 0;
			for (var n in nodes)
			{
				if (n.Value != 0)
				{
					Value = n.Value;
					break;
				}
			}
			IntValue = Math.Sign(Value);

			//Press
			if (last != IntValue && IntValue != 0)
				lastPress = Time.Elapsed;
			Pressed = IntValue != 0 && lastPress > lastPressClear && Time.Elapsed - lastPress <= pressBuffer;

			//Repeat
			if (IntValue != 0 && repeatStart > 0 && Time.Elapsed - lastPress >= repeatStart)
			{
				Repeating = true;

				int a = (int)((Time.PreviousElapsed - lastPress) / repeatInterval);
				int b = (int)((Time.Elapsed - lastPress) / repeatInterval);
				if (a != b)
					Pressed = true;
			}
			else
				Repeating = false;

			//Release
			if (last != 0 && IntValue == 0)
				lastRelease = Time.Elapsed;
			Released = IntValue == 0 && lastRelease > lastReleaseClear && Time.Elapsed - lastRelease <= releaseBuffer;
		}

		public void ClearPressBuffer()
		{
			lastPressClear = Time.Elapsed;
		}

		public void ClearReleaseBuffer()
		{
			lastReleaseClear = Time.Elapsed;
		}

		// Setup Calls

		public VirtualAxis Keys(SDL2.SDL.Scancode negativeKey, SDL2.SDL.Scancode positiveKey, OverlapBehaviors overlapBehavior = .TakeNewer)
		{
			nodes.Add(new KeyboardKeys(negativeKey, positiveKey, overlapBehavior));
			return this;
		}

		public VirtualAxis PressBuffer(float time)
		{
			pressBuffer = time;
			return this;
		}

		public VirtualAxis ReleaseBuffer(float time)
		{
			releaseBuffer = time;
			return this;
		}

		public VirtualAxis Repeat(float start, float interval)
		{
			repeatStart = start;
			repeatInterval = interval;
			return this;
		}

		// Nodes

		private abstract class Node
		{
			public abstract float Value { get; }
			public virtual void Update() { }
		}

		private class KeyboardKeys : Node
		{
			public OverlapBehaviors OverlapBehavior;
			public SDL2.SDL.Scancode NegativeKeycode;
			public SDL2.SDL.Scancode PositiveKeycode;

			private float value;
			private bool turned;

			public this(SDL2.SDL.Scancode negativeKey, SDL2.SDL.Scancode positiveKey, OverlapBehaviors overlapBehavior = .TakeNewer)
			{
				NegativeKeycode = negativeKey;
				PositiveKeycode = positiveKey;
				OverlapBehavior = overlapBehavior;
			}

			public override void Update()
			{
				if (Game.IsKeyDown(PositiveKeycode))
				{
				    if (Game.IsKeyDown(NegativeKeycode))
				    {
				        switch (OverlapBehavior)
				        {
				            case OverlapBehaviors.CancelOut:
				                value = 0;
				                break;

				            case OverlapBehaviors.TakeNewer:
				                if (!turned)
				                {
				                    value *= -1;
				                    turned = true;
				                }
				                break;

				            case OverlapBehaviors.TakeOlder:
				                //value stays the same
				                break;
				        }
				    }
				    else
				    {
				        turned = false;
				        value = 1;
				    }
				}
				else if (Game.IsKeyDown(NegativeKeycode))
				{
				    turned = false;
				    value = -1;
				}
				else
				{
				    turned = false;
				    value = 0;
				}
			}

			public override float Value
			{
				get
				{
					return value;
				}
			}
		}
	}
}
