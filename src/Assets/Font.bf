using System;
using SDL2;
using System.IO;
using System.Text;
using System.Collections;

namespace Strawberry
{
	public class Font : Asset
	{
		private Dictionary<int32, SDLTTF.Font*> fonts;

		private this(String path)
			: base(path)
		{
			fonts = new Dictionary<int32, SDLTTF.Font*>();
			Load();
		}

		public SDLTTF.Font* this[int32 size]
		{
			get
			{
				if (fonts.ContainsKey(size) && fonts[size] != null)
					return fonts[size];
				else
				{
					Calc.Log(Path);
					let f = SDLTTF.OpenFont(Path, size);
					fonts[size] = f;
					return f;
				}
			}
		}	

		protected override void Load()
		{
			Runtime.Assert(File.Exists(Path), "Font does not exist!");

			for (let k in fonts.Keys)
				fonts[k] = SDLTTF.OpenFont(Path, k);
		}

		protected override void Unload()
		{
			for (let kv in fonts)
			{
				SDLTTF.CloseFont(kv.value);
				fonts[kv.key] = null;
			}
			delete fonts;
		}
	}
}
