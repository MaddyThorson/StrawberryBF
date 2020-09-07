using System;
using System.Collections;
using System.IO;

namespace Strawberry
{
	static public class Assets
	{
		static public Dictionary<String, Texture> Textures { get; private set; }

		#if DEBUG
		static public readonly String Root = "../../../src/assets/";
		#else
		static public readonly String Root = "assets/";
		#endif

		static public void LoadAll()
		{
			Textures = new Dictionary<String, Texture>();
			Load<Texture>("textures", "*.png", Textures, (path) => Game.PlatformLayer.LoadTexture(path));
		}

		static public void DisposeAll()
		{
			DeleteDictionaryAndKeysAndItems!(Textures);
			Sprite.[Friend]Dispose();
		}

		static private void Load<T>(String directory, String wildcard, Dictionary<String, T> putInto, function T(String) loader)
		{
			let root = scope String(Root);
			root.Append(Path.DirectorySeparatorChar);
			root.Append(directory);
			if (Directory.Exists(root))
				LoadDir<T>(root, root, wildcard, putInto, loader);
			else
				Calc.Log("Create a Content/{0} folder to load {0}", directory);
		}

		static private void LoadDir<T>(String rootDir, String directory, String wildcard, Dictionary<String, T> putInto, function T(String) loader)
		{
			//Recursive folder search
			for (let dir in Directory.EnumerateDirectories(directory))
			{
				let path = scope String();
				dir.GetFilePath(path);
				LoadDir<T>(rootDir, path, wildcard, putInto, loader);
			}

			//Load files
			for (let file in Directory.EnumerateFiles(directory, wildcard))
			{
				let path = scope String();
				file.GetFilePath(path);
				let asset = loader(path);

				let key = new String(path);
				key.Remove(0, rootDir.Length + 1);
				key.RemoveFromEnd(key.Length - key.IndexOf('.'));
				putInto.Add(key, asset);
			}
		}
	}
}
