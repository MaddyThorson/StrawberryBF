using System;
using System.Collections;
using System.Reflection;
using Strawberry;

namespace Strawberry
{
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
			Calc.Log(commands.Count);
		}

		static public void Dispose()
		{
			SDL2.SDLTTF.CloseFont(font);
			delete entry;
			DeleteContainerAndItems!(commandHistory);
			DeleteContainerAndItems!(messages);
			DeleteDictionaryAndKeysAndItems!(commands);
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
			let string = Calc.[Friend]StringArgs(scope String(str), args);
			Log(string);
		}

		[AlwaysInclude]
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
				Calc.Log("hey {0}");

				if (commands.ContainsKey(list[0]))
				{
					Log(line);
					//Do it
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
			public delegate void(String[]) Action ~ delete _;
			public String Help;
			public String Usage ~ delete _;

			public this(MethodInfo method, CommandAttribute attr)
			{
				Help = attr.Help;
			}
		}
	}
}
