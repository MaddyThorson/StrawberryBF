using System;
using System.IO;

namespace Strawberry
{
	public abstract class Asset
	{
		public readonly String Path ~ delete _;

		protected this(String path)
		{
			Path = path;
		}

		public ~this()
		{
			Unload();
		}

		protected mixin OpenFileStream()
		{
			let stream = scope:: FileStream();
			stream.Open(Path, .Read, .Read);
			stream
		}

		protected abstract void Load();
		protected abstract void Unload();

		public void Reload()
		{
			Unload();
			Load();
		}
	}
}
