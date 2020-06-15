using System;
using SDL2;
using System.IO;
using System.Text;

namespace Strawberry
{
	public class Font : Asset
	{
		public SDLTTF.Font* Font { get; private set; }
		public int32 Size { get; private set; }

		private String sizePath ~ delete _;

		private this(String path)
			: base(path)
		{
			sizePath = new String(path);
			sizePath.RemoveFromEnd(4);
			sizePath.Append(".txt");

			Load();
		}

		private this(String path, int32 size)
			: base(path)
		{
			sizePath = null;
			Size = size;

			Load();
		}

		protected override void Load()
		{
			if (sizePath != null)
			{
				if (File.Exists(sizePath))
				{
					//Load size
					let stream = scope FileStream();
					stream.Open(sizePath, .Read);
					let arr = scope uint8[stream.Length];
					for (let i < arr.Count)
						arr[i] = stream.Read<uint8>();
					stream.Close();
	
					let str = scope String();
					Encoding.UTF8.DecodeToUTF8(arr, str);
	
					Size = int32.Parse(str);
				}
				else
				{
					//Create size file
					let stream = scope FileStream();
					stream.Create(sizePath, .Write);
	
					stream.Write("12");
					stream.Close();
	
					Calc.Log("Warning: Edit '{0}' to define load size of font '{1}'", sizePath, Path);
	
					Size = 12;
				}
			}

			Font = SDLTTF.OpenFont(Path, Size);
		}

		protected override void Unload()
		{
			SDLTTF.CloseFont(Font);
		}
	}
}
