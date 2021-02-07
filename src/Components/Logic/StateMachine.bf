using System;
using System.Collections;
using System.Diagnostics;

namespace Strawberry
{
	public class StateMachine<TIndex> : Component, IUpdate where TIndex : struct, IHashable
	{
		private Dictionary<TIndex, State> states = new Dictionary<TIndex, State>() ~ delete _;
		private TIndex state;
		private bool inStateCall;

		public TIndex PreviousState { get; private set; }
		public TIndex NextState { get; private set; }

		public this(TIndex startState)
		{
			NextState = PreviousState = state = startState;
		}

		public ~this()
		{
			for (let s in states.Values)
				 delete s;
		}

		public override void Awake()
		{
			CallEnter();
		}

		public void Update()
		{
			CallUpdate();
		}

		public void Add(TIndex state, delegate void() enter = null, delegate TIndex() update = null, delegate void() exit = null)
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
			Debug.Assert(states.ContainsKey(to), "State does not exist in this State Machine. Call Add() first!");
			Runtime.Assert(!inStateCall, "Cannot set State directly from inside a State Enter/Exit/Update call. Return the desired State change instead.");

			if (to != state)
			{
				NextState = to;
				CallExit();
				PreviousState = state;
				state = to;
				CallEnter();
				return true;
			}
			else
				return false;
		}

		private void CallEnter()
		{
			let s = states[state];
			if (s != null && s.Enter != null)
			{
				inStateCall = true;
				s.Enter();
				inStateCall = false;
			}
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

		private void CallExit()
		{
			let s = states[state];
			if (s != null && s.Exit != null)
			{
				inStateCall = true;
				s.Exit();
				inStateCall = false;
			}
		}

		public class State
		{
			public delegate void() Enter ~ delete _;
			public delegate TIndex() Update ~ delete _;
			public delegate void() Exit ~ delete _;
		}
	}
}
