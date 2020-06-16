using System;
using System.Collections;
using System.IO;

namespace Strawberry
{
	static public class Assets
	{
		static public Dictionary<String, Sprite> Sprites { get; private set; }
		static public Dictionary<String, Font> Fonts { get; private set; }

		static public String ContentRoot { get; private set; }

		static public void LoadAll()
		{
		#if DEBUG
			ContentRoot = "../../../src/Content/";
		#else
			ContentRoot = "Content";
		#endif 

			Sprites = new Dictionary<String, Sprite>();
			Load<Sprite>("Sprites", "*.ase*", Sprites);

			Fonts = new Dictionary<String, Font>();
			Load<Font>("Fonts", "*.ttf", Fonts);
		}

		static public void DisposeAll()
		{
			DeleteDictionaryAndKeysAndItems!(Sprites);
			DeleteDictionaryAndKeysAndItems!(Fonts);
			Sprite.[Friend]Dispose();
		}

		static private void Load<T>(String directory, String wildcard, Dictionary<String, T> putInto) where T : Asset
		{
			let root = scope String(ContentRoot);
			root.Append(Path.DirectorySeparatorChar);
			root.Append(directory);
			if (Directory.Exists(root))
				LoadDir<T>(root, root, wildcard, putInto);
			else
				Calc.Log("Create a Content/{0} folder to load {0}", directory);
		}

		static private void LoadDir<T>(String rootDir, String directory, String wildcard, Dictionary<String, T> putInto) where T : Asset
		{
			//Recursive folder search
			for (let dir in Directory.EnumerateDirectories(directory))
			{
				let path = scope String();
				dir.GetFilePath(path);
				LoadDir<T>(rootDir, path, wildcard, putInto);
			}

			//Load files
			for (let file in Directory.EnumerateFiles(directory, wildcard))
			{
				let path = new String();
				file.GetFilePath(path);
				let asset = new [Friend]T(path);

				let key = new String(path);
				key.Remove(0, rootDir.Length + 1);
				key.RemoveFromEnd(key.Length - key.IndexOf('.'));
				putInto.Add(key, asset);
			}
		}
	}
}
