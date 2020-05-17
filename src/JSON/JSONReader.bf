using System;
using System.IO;

namespace Strawberry
{
	public class JSONReader
	{
		private enum Tokens { Key, Null, Bool, Number, String, ObjectStart, ObjectEnd, ArrayStart, ArrayEnd };

		public JSON JSON { get; private set; }

		private int index;
		private String data;
		private String buffer = new String() ~ delete _;
		private bool boolValue;
		private float numberValue;

		private bool EndOfFile => index >= data.Length;

		public this(String data)
		{
			index = 0;
			this.data = data;

			let t = Read();
			if (t != .ObjectStart)
				Runtime.FatalError("Expected {");
			JSON = ReadObject();
		}

		public JSON ReadObject()
		{
			JSON json = new JSON();
			String currentKey = null;

			while (!EndOfFile)
			{
				let t = Read();

				if (currentKey == null)
				{
					if (t == .ObjectEnd)
						break;
					else if (t != .Key)
						Runtime.FatalError("Expected key");

					currentKey = new String(buffer);
				}
                else
				{
					switch (t)
					{
					case .Null:
						json[currentKey] = Strawberry.JSON.CreateNull();

					case .Bool:
						json[currentKey] = boolValue;

					case .Number:
						json[currentKey] = numberValue;

					case .String:
						json[currentKey] = buffer;

					case .ObjectStart:
						json[currentKey] = ReadObject();

					case .ArrayStart:
						json[currentKey] = ReadArray();

					default:
						Runtime.FatalError("Unexpected token");
					}

					currentKey = null;
				}
			}

			return json;
		}

		public JSON ReadArray()
		{
			JSON json = Strawberry.JSON.CreateArray();

			L: while (!EndOfFile)
			{
				let t = Read();
				switch (t)
				{
				case .ArrayEnd:
					break L;

				case .Null:
					json.ArrayPush(Strawberry.JSON.CreateNull());

				case .Bool:
					json.ArrayPush(boolValue);

				case .Number:
					json.ArrayPush(numberValue);

				case .String:
					json.ArrayPush(buffer);

				case .ObjectStart:
					json.ArrayPush(ReadObject());

				case .ArrayStart:
					json.ArrayPush(ReadArray());

				default:
					Calc.Log(t);
					Runtime.FatalError("Unexpected token");
				}
			}

			return json;
		}

		private char8 Step()
		{
			if (index < data.Length)
				return data[index++];
			else
				return 0;
		}

		private char8 Peek()
		{
			if (index < data.Length)
				return data[index];
			else
				return 0;
		}

		private bool IsWhitespace(char8 char)
		{
			return char == ' ' || char == '\t' || char == '\n' || char == '\r';
		}

		private Tokens Read()
		{
			bool inComment = false;
			buffer.Clear();

			while (!EndOfFile)
			{
				char8 c = Step();

				//Finish Comments
				if (inComment)
				{
					if (c == '\n' || c == '\r')
						inComment = false;
					continue;
				}

				switch (c)
				{
				case '#':
				case '/' when Peek() == '/':
					inComment = true;
					continue;

				case ' ':
				case '\n':
				case '\t':
				case '\r':
				case ':':
				case ',':
					continue;

				case '{':
					return Tokens.ObjectStart;

				case '}':
					return Tokens.ObjectEnd;

				case '[':
					return Tokens.ArrayStart;

				case ']':
					return Tokens.ArrayEnd;

				case '"':
					while (!EndOfFile && Peek() != '"')
						buffer.Append(Step());
					Step();

					while (IsWhitespace(Peek()))
						Step();

					if (Peek() == ':')
						return Tokens.Key;
					else
						return Tokens.String;

				default:
					buffer.Append(c);
					while (!EndOfFile && !(" \r\n,:{}[]#").Contains(Peek()))
						buffer.Append(Step());

					if (buffer.Equals("null", .InvariantCultureIgnoreCase))
						return Tokens.Null;
					else if (buffer.Equals("true", .InvariantCultureIgnoreCase))
					{
						boolValue = true;
						return Tokens.Bool;
					}
					else if (buffer.Equals("false", .InvariantCultureIgnoreCase))
					{
						boolValue = false;
						return Tokens.Bool;
					}
					else
					{
						if (float.Parse(buffer) case .Err)
							Calc.Log(buffer);
						numberValue = float.Parse(buffer);
						return Tokens.Number;
					}
				}
			}

			Runtime.FatalError("Malformed JSON");
		}
	}
}
