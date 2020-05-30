using System;
using System.Collections;

namespace Strawberry
{
	public class StateMachine<TIndex> : Component where TIndex : struct, IHashable
	{
		private Dictionary<TIndex, State> states = new Dictionary<TIndex, State>() ~ delete _;
		private TIndex state;
		private bool inStateCall;

		public TIndex PreviousState { get; private set; }
		public TIndex NextState { get; private set; }

		public this(TIndex startState)
			: base(true, false)
		{
			NextState = PreviousState = state = startState;
		}

		public ~this()
		{
			for (let s in states.Values)
				 delete s;
		}

		public override void Started()
		{
			CallEnter();
		}

		public override void Update()
		{
			CallUpdate();
		}

		public override void Draw()
		{

		}

		public void Add(TIndex state, delegate TIndex() enter = null, delegate TIndex() update = null, delegate TIndex() exit = null)
		{
			let s = new State();
			s.Enter = enter;
			s.Update = update;
			s.Exit = exit;
			states[state] = s;
		}

		public TIndex State
		{
			get => state;
			set => Set(value);
		}

		private Result<bool> Set(TIndex to)
		{
			if (!states.ContainsKey(to))
				Runtime.FatalError("State does not exist in this State Machine. Call Add() first!");
			if (inStateCall)
				Runtime.FatalError("Cannot set State directly from inside a State Enter/Exit/Update call. Return the desired State change instead.");

			if (to != state)
			{
				NextState = to;
				if (CallExit())
					return true;

				PreviousState = state;
				state = to;

				CallEnter();
				return true;
			}
			else
				return false;
		}

		private bool CallEnter()
		{
			let s = states[state];
			if (s != null && s.Enter != null)
			{
				inStateCall = true;
				let set = s.Enter();
				inStateCall = false;
				return Set(set);
			}
			else
				return false;
		}

		private bool CallUpdate()
		{
			let s = states[state];
			if (s != null && s.Update != null)
			{
				inStateCall = true;
				let set = s.Update();
				inStateCall = false;
				return Set(set);
			}
			else
				return false;
		}

		private bool CallExit()
		{
			let s = states[state];
			if (s != null && s.Exit != null)
			{
				inStateCall = true;
				let set = s.Exit();
				inStateCall = false;
				return Set(set);
			}
			else
				return false;
		}

		public class State
		{
			public delegate TIndex() Enter;
			public delegate TIndex() Update;
			public delegate TIndex() Exit;

			public ~this()
			{
				if (Enter != null)
					delete Enter;
				if (Update != null)
					delete Update;
				if (Exit != null)
					delete Exit;
			}
		}
	}
}
