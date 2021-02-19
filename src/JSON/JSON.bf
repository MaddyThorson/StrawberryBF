/*
	JSON I/O based on Noel Berry's C# JSON library
	https://github.com/NoelFB/JSON
*/

using System.IO;
using System;
using System.Collections;

namespace Strawberry
{
	public class JSON
	{
		public enum Types { Null, Bool, Number, String, Array, Object };

		public Types Type { get; private set; }
		public readonly bool Bool;
		public readonly float Number;
		public readonly String String;

		public int Int => (int)Number;
		public char8 Char => String[0];
		public T Enum<T>() where T : Enum
		{
			Runtime.Assert(Type == .String);
			return T.Parse<T>(String, true);
		}

		public Point Point => .(this["x"].Int, this["y"].Int);
		public Vector Vector => .(this["x"].Number, this["y"].Number);

		private List<JSON> array;
		private Dictionary<String, JSON> children;

		public this()
		{
			Type = .Object;
			children = new Dictionary<String, JSON>();
		}

		public this(bool value)
		{
			Type = .Bool;
			Bool = value;
		}

		public this(int value)
		{
			Type = .Number;
			Number = value;
		}

		public this(float value)
		{
			Type = .Number;
			Number = value;
		}

		public this(String value)
		{
			Type = .String;
			String = new String(value);
		}

		public this(params JSON[] value)
		{
			Type = .Array;
			array = new List<JSON>(value.GetEnumerator());
		}

		private this(Types type)
		{
			Type = type;
		}

		public ~this()
		{
			if (String != null)
				delete String;

			if (array != null)
			{
				for (let a in array)
					delete a;
				delete array;
			}

			if (children != null)
			{
				for (let a in children)
				{
					delete a.key;
					delete a.value;
				}
				delete children;
			}
		}

		// Array

		public JSON this[int index]
		{
			get
			{
				Runtime.Assert(Type == .Array);
				return array[index];
			}

			set
			{
				Runtime.Assert(Type == .Array);
				array[index] = value;
			}
		}

		public int ArrayLength
		{
			get
			{
				Runtime.Assert(Type == .Array);
				return array.Count;
			}
		}

		public void ArrayPush(JSON json)
		{
			Runtime.Assert(Type == .Array);
			array.Add(json);
		}

		public void ArrayRemoveAt(int index)
		{
			Runtime.Assert(Type == .Array);
			let a = array[index];
			array.RemoveAt(index);
			delete a;
		}

		public void ArrayClear()
		{
			Runtime.Assert(Type == .Array);
			for (let a in array)
				delete a;
			array.Clear();
		}

		public List<JSON>.Enumerator ArrayEnumerator
		{
			get
			{
				Runtime.Assert(Type == .Array);
				return array.GetEnumerator();
			}
		}

		// Object

		public JSON this[String key]
		{
			get
			{
				Runtime.Assert(Type == .Object);

				if (children.ContainsKey(key))
					return children[key];
				else
					return null;
			}

			set
			{
				Runtime.Assert(Type == .Object);

				//Remove previous child under that key
				RemoveChild(key);

				//Add new child
				children.Add(key, value);
			}
		}

		public void RemoveChild(String key)
		{
			Runtime.Assert(Type == .Object);
			if (children.ContainsKey(key))
				delete children.GetAndRemove(key).Value.value;
		}

		public Dictionary<String, JSON>.Enumerator ObjectEnumerator
		{
			get
			{
				Runtime.Assert(Type == .Object);
				return children.GetEnumerator();
			}
		}

		public Dictionary<String, JSON>.KeyEnumerator ObjectKeyEnumerator
		{
			get
			{
				Runtime.Assert(Type == .Object);
				return children.Keys;
			}
		}

		public Dictionary<String, JSON>.ValueEnumerator ObjectValueEnumerator
		{
			get
			{
				Runtime.Assert(Type == .Object);
				return children.Values;
			}
		}

		// Operators

		static public implicit operator JSON(bool val)
		{
			return new JSON(val);
		}

		static public implicit operator JSON(int val)
		{
			return new JSON(val);
		}

		static public implicit operator JSON(float val)
		{
			return new JSON(val);
		}

		static public implicit operator JSON(String val)
		{
			return new JSON(val);
		}

		static public implicit operator JSON(char8 val)
		{
			let str = scope String();
			str.Concat(val);
			return new JSON(str);
		}

		static public implicit operator bool(JSON json)
		{
			Runtime.Assert(json.Type == .Bool);
			return json.Bool;
		}

		static public implicit operator int(JSON json)
		{
			Runtime.Assert(json.Type == .Number);
			return (int)json.Number;
		}

		static public implicit operator float(JSON json)
		{
			Runtime.Assert(json.Type == .Number);
			return json.Number;
		}

		static public implicit operator String(JSON json)
		{
			Runtime.Assert(json.Type == .String);
			return json.String;
		}

		static public implicit operator char8(JSON json)
		{
			Runtime.Assert(json.Type == .String);
			return json.String[0];
		}

		static public JSON CreateArray()
		{
			let json = new JSON(.Array);
			json.array = new List<JSON>();
			return json;
		}

		static public JSON CreateNull()
		{
			return new JSON(.Null);
		}

		// Out

		public void ToString(String strBuffer, int tabLevel)
		{
			switch (Type)
			{
			case .Null:
				strBuffer.Append("null");
				break;

			case .Bool:
				Bool.ToString(strBuffer);
				break;

			case .Number:
				Number.ToString(strBuffer);
				break;

			case .String:
				strBuffer.Append('"');
				strBuffer.Append(String);
				strBuffer.Append('"');
				break;

			case .Array:
				strBuffer.Append("[\n");
				for (int i < array.Count)
				{
					for (let t < tabLevel + 1)
						strBuffer.Append('\t');
					array[i].ToString(strBuffer, tabLevel + 1);
					if (i < array.Count - 1)
						strBuffer.Append(',');
					strBuffer.Append('\n');
				}
				for (let t < tabLevel)
					strBuffer.Append('\t');
				strBuffer.Append("]");
				break;

			case .Object:
				strBuffer.Append("{\n");
				int c = 0;
				for (let o in children)
				{
					for (let t < tabLevel + 1)
						strBuffer.Append('\t');
					strBuffer.Append('"');
					strBuffer.Append(o.key);
					strBuffer.Append("\": ");
					o.value.ToString(strBuffer, tabLevel + 1);

					c++;
					if (c < children.Count)
						strBuffer.Append(',');
					strBuffer.Append('\n');
				}
				for (let t < tabLevel)
					strBuffer.Append('\t');
				strBuffer.Append("}");
			}
		}

		public override void ToString(String strBuffer)
		{
			ToString(strBuffer, 0);
		}

		public void ToStream(Stream stream)
		{
			let str = scope String();
			ToString(str);
			for (let i < str.Length)
				stream.Write<char8>(str[i]);
		}

		public void ToFile(String filePath)
		{
			if (File.Exists(filePath))
				File.Delete(filePath);

			FileStream stream = scope FileStream();
			stream.Create(filePath, .Write);
			ToStream(stream);
			stream.Close();
		}

		// In

		static public JSON FromString(String string)
		{
			return (scope JSONReader(string)).JSON;
		}

		static public JSON FromStream(Stream stream)
		{
			String str = scope String();
			while (stream.Position < stream.Length)
			{
				let char = stream.Read<char8>();
				if (char case .Err)
					Runtime.FatalError("File read error!");
				else
					str.Append(char);
			}

			return (scope JSONReader(str)).JSON;
		}

		static public JSON FromFile(String filePath)
		{
			FileStream stream = scope FileStream();

			let str = scope String();
			Directory.GetCurrentDirectory(str);
			Calc.Log(str);

			

			if (stream.Open(filePath, .Read) case .Err)
				Runtime.FatalError("Unable to open FileStream");
			let json = FromStream(stream);
			stream.Close();

			return json;
		}
	}
}
