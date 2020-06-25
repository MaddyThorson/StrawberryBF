using System;
using System.Collections;
using System.Reflection;
using Strawberry;

namespace Strawberry
{
	[AttributeUsage(.Method, .AlwaysIncludeTarget | .ReflectAttribute)]
	public struct CommandAttribute : Attribute
	{
		public String Name;
		public String Help;

		public this(String name, String help = "")
		{
			Name = name;
			Help = help;
		}
	}

	[Reflect]
	static public class Console
	{
		static public bool Open;

		static private bool enabled;
		static private SDL2.SDLTTF.Font* font;
		static private String entry;
		static private List<String> commandHistory;
		static private List<String> messages;
		static private Dictionary<String, CommandInfo> commands;

		static public void Init()
		{
			enabled = true;
			font = SDL2.SDLTTF.OpenFont("../../../../Strawberry/src/Content/strawberry-seeds.ttf", 8);
			entry = new String();
			commandHistory = new List<String>();
			messages = new List<String>();
			commands = new Dictionary<String, CommandInfo>();

			//Find commands
			for (let type in Type.Types)
			{
				for (let method in type.GetMethods(.Static | .NonPublic | .Public))
				{
					let attr = method.GetCustomAttribute<CommandAttribute>();
					if (attr != .Err)
						commands.Add(attr.Value.Name, new CommandInfo(method, attr.Value));
				}
			}
		}

		static public void Dispose()
		{
			SDL2.SDLTTF.CloseFont(font);
			delete entry;
			DeleteContainerAndItems!(commandHistory);
			DeleteContainerAndItems!(messages);
			for (let c in commands.Values)
				delete c;
			delete commands;
		}

		static public bool Enabled
		{
			get => enabled;
			set
			{
				enabled = value;
				if (!enabled)
					Open = false;
			}
		}

		static public void Log(StringView str)
		{
			messages.Add(new String(str));
			while (messages.Count > MessageRows)
			{
				delete messages[0];
				messages.RemoveAt(0);
			}
		}

		static public void Log(StringView str, params Object[] args)
		{
			let string = Calc.[Friend]StringArgs(scope String(str), params args);
			Log(string);
		}

		[Reflect]
		[Command("clear", "Clears the console window")]
		static public void Clear()
		{
			DeleteAndClearItems!(messages);
		}

		static private void Update()
		{
			if (enabled)
			{
				if (Input.KeyPressed(.Grave))
					Open = !Open;
	
				if (Open)
				{
					Input.KeystrokesIntoString(entry, 0.25f, 0.05f);
					if (Input.KeyPressed(.Delete))
						entry.Clear();
					if (Input.KeyPressed(.Return) && entry.Length > 0 && !String.IsNullOrWhiteSpace(entry))
						SubmitEntry();
				}
			}
		}

		static private void SubmitEntry()
		{
			let line = new String(entry);
			commandHistory.Add(line);
			Log(line);

			//Parse command and arguments
			{
				let list = String.StackSplit!(line, ' ');
				list.RemoveAll(scope => String.IsNullOrWhiteSpace);

				if (commands.ContainsKey(list[0]))
				{
					Log(line);
					let args = scope String[list.Count - 1];
					for (let i < args.Count)
						args[i] = list[i + 1];
					commands[list[0]].Call(args);
				}
				else
					Log("Command '{0}' not recognized.", list[0]);
			}

			entry.Clear();
		}

		static private void Draw()
		{
			if (enabled && Open)
			{
				Draw.Rect(0, 0, Game.Width, Game.Height, .Black * 0.6f);
				Draw.Rect(0, Game.Height - 14, Game.Width, 14, .Black * 0.6f);

				//Entry
				if (entry.Length > 0)
					Text(entry, 0, 0, .White);
				if (Time.BetweenInterval(0.25f))
					Text("_", 0, entry.Length, .White);

				//Messages
				for (int i = messages.Count - 1; i >= 0; i--)
					Text(messages[i], messages.Count - i, 0, .White);
			}
		}

		static private void Text(String str, int row, int col, Color color)
		{
			Point pos = .(4 + 6 * col, Game.Height - 10 - 10 * row);
			if (row > 0)
				pos.Y -= 4;

			Draw.Text(font, str, pos + .Down, .Black);
			Draw.Text(font, str, pos, color);
		}

		static private int MessageRows => (int)Math.Ceiling((Game.Height - 14) / 10f);

		private class CommandInfo
		{
			public String Help;
			public String Usage ~ delete _;
			public MethodInfo Method;

			public this(MethodInfo method, CommandAttribute attr)
			{
				Help = attr.Help;
				Method = method;
			}

			public void Call(String[] args)
			{
				if (Method.ParamCount == 0)
					Method.Invoke(null);
				else
				{
					let objs = scope Object[Method.ParamCount];
					for (let i < objs.Count)
					{
						if (i < args.Count)
							objs[i] = Convert(args[i], Method.GetParamType(i));
						else
							objs[i] = Method.GetParamType(i).CreateValueDefault();
					}
	
					Method.Invoke(null, params objs);
				}
			}
		}

		static private Object Convert(String str, Type type)
		{
			switch (type)
			{
			case typeof(StringView):
				return str;

			case typeof(int):
				return int.Parse(str).Value;

			case typeof(float):
				return float.Parse(str).Value;

			case typeof(bool):
				return bool.Parse(str).Value;

			case typeof(String):
				Runtime.FatalError("String arguments not supported in commands. Use StringView instead.");

			default:
				{
					let name = scope String();
					type.GetName(name);
					let error = Calc.StringArgs("{0} type arguments not supported in commands.", scope Object[] { name });
					Runtime.FatalError(error);
				}
				
			}
		}
	}
}
