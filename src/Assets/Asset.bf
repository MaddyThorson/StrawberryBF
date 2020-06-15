using System;
namespace Strawberry
{
	public abstract class Asset
	{
		public readonly String Path;

		protected this(String path)
		{
			Path = path;
		}
	}
}
