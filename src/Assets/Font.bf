using System;
using SDL2;

namespace Strawberry
{
	public class Font : Asset
	{
		private SDLTTF.Font* font;

		private this(String path)
			: base(path)
		{

		}

		public ~this()
		{
			SDLTTF.CloseFont(font);
		}
	}
}
