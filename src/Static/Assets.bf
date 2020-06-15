using System;
using System.Collections;
using System.IO;

namespace Strawberry
{
	static public class Assets
	{
		static public Dictionary<String, Sprite> Sprites { get; private set; }
		static public Dictionary<String, Font> Fonts { get; private set; }

		static public void LoadAll()
		{
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
			let root = scope String(Game.ContentRoot);
			root.Append(Path.DirectorySeparatorChar);
			root.Append(directory);
			if (Directory.Exists(root))
				LoadDir<T>(root, wildcard, putInto);
			else
				Calc.Log("Content/{0} folder does not exist!", directory);
		}

		static private void LoadDir<T>(String directory, String wildcard, Dictionary<String, T> putInto) where T : Asset
		{
			//Recursive folder search
			for (let dir in Directory.EnumerateDirectories(directory))
			{
				let path = scope String();
				dir.GetFilePath(path);
				LoadDir<T>(path, wildcard, putInto);
			}

			//Load files
			for (let file in Directory.EnumerateFiles(directory, wildcard))
			{
				let path = scope String();
				file.GetFilePath(path);
				let sprite = new [Friend]T(path);

				path.Remove(0, Game.ContentRoot.Length + 9);
				path.RemoveFromEnd(path.Length - path.IndexOf('.'));
				putInto.Add(new String(path), sprite);
			}
		}
	}
}
