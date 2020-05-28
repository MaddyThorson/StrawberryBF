using System;
using SDL2;
using System.IO;
using System.Text;
using System.Collections;
using MiniZ;

namespace Strawberry
{
	public class Sprite
	{
		private enum Modes
		{
		    Indexed = 1,
		    Grayscale = 2,
		    RGBA = 4,
		}

		private enum Chunks
		{
		    OldPaletteA = 0x0004,
		    OldPaletteB = 0x0011,
		    Layer = 0x2004,
		    Cel = 0x2005,
		    CelExtra = 0x2006,
		    Mask = 0x2016,
		    Path = 0x2017,
		    FrameTags = 0x2018,
		    Palette = 0x2019,
		    UserData = 0x2020,
		    Slice = 0x2022
		}

		public readonly String Path;

		public int Width { get; private set; }
		public int Height { get; private set; }

		private Frame[] frames;
		private List<Layer> layers;
		private List<Tag> tags;
		private List<Slice> slices;
		private Modes mode;

		private this(String path)
		{
			Path = new String(path);
			Load();
		}

		public ~this()
		{
			delete Path;
			Unload();
		}

		public Frame this[int index]
		{
			get => frames[index];
		}

		private void Unload()
		{
			for (let f in frames)
				delete f;
			delete frames;

			for (let l in layers)
				delete l;
			delete layers;

			for (let t in tags)
				delete t;
			delete tags;

			for (let s in slices)
				delete s;
			delete slices;
		}

		public void Reload()
		{
			Unload();
			Load();
		}

		private void Load()
		{
			/*
				Aseprite file loading based on code from Noel Berry's Foster Framework here:
				https://github.com/NoelFB/Foster/blob/master/Framework/Graphics/Images/Aseprite.cs
			*/

			let stream = scope FileStream();
			stream.Open(Path, .Read, .Read);

			//Helpers to match ASE file format spec
			uint8 BYTE() => stream.Read<uint8>();
			uint16 WORD() => stream.Read<uint16>();
			int16 SHORT() => stream.Read<int16>();
			uint32 DWORD() => stream.Read<uint32>();
			int32 LONG() => stream.Read<int32>();
			void SEEK(int bytes) => stream.Position += bytes;
			void BYTES(uint8[] into, int bytes)
			{
				for (let i < bytes)
					into[i] = BYTE();
			}
			String STRING(String into)
			{
				let len = WORD();
				let arr = scope uint8[len];
				for (let i < len)
					arr[i] = BYTE();

				Encoding.UTF8.DecodeToUTF8(arr, into);
				return into;
			}

			//Parse
			{
				//Header
				{
					//File Size
					DWORD();

					// Magic number
					var magic = WORD();
					if (magic != 0xA5E0)
						Runtime.FatalError("File is not in .ase format");

					// Frame Count / Width / Height / Color Mode
					frames = new Frame[WORD()];
					Width = WORD();
					Height = WORD();
					mode = (Modes)(WORD() / 8);

					// Other Info, Ignored
					DWORD();       // Flags
					WORD();        // Speed (deprecated)
					DWORD();       // Set be 0
					DWORD();       // Set be 0
					BYTE();        // Palette entry 
					SEEK(3);       // Ignore these bytes
					WORD();        // Number of colors (0 means 256 for old sprites)
					BYTE();        // Pixel width
					BYTE();        // Pixel height
					SEEK(92);      // For Future
				}

				layers = new List<Layer>();
				tags = new List<Tag>();
				slices = new List<Slice>();

				// Body
				{
					var temp = scope:: uint8[Width * Height * (int)mode];
					let palette = scope:: Color[256];
					HasUserData last = null;

					for (int i = 0; i < frames.Count; i++)
					{
					    let frame = new Frame(Width, Height);
					    frames[i] = frame;

					    int64 frameStart, frameEnd;
					    int chunkCount;

					    // frame header
					    {
					        frameStart = stream.Position;
					        frameEnd = frameStart + DWORD();
					        WORD();                  // Magic number (always 0xF1FA)
					        chunkCount = WORD();     // Number of "chunks" in this frame
					        frame.Duration = WORD(); // Frame duration (in milliseconds)
					        SEEK(6);                 // For future (set to zero)
					    }

					    // chunks
					    for (int j = 0; j < chunkCount; j++)
					    {
					        int64 chunkStart, chunkEnd;
					        Chunks chunkType;

					        // chunk header
					        {
					            chunkStart = stream.Position;
					            chunkEnd = chunkStart + DWORD();
					            chunkType = (Chunks)WORD();
					        }

					        // LAYER CHUNK
					        if (chunkType == Chunks.Layer)
					        {
					            // create layer
					            var layer = new Layer();

					            // get layer data
					            layer.Flag = (Layer.Flags)WORD();
					            layer.Type = (Layer.Types)WORD();
					            layer.ChildLevel = WORD();
					            WORD(); // width (unused)
					            WORD(); // height (unused)
					            layer.BlendMode = WORD();
					            layer.Alpha = (BYTE() / 255f);
					            SEEK(3); // for future
					            STRING(layer.Name);

					            layers.Add(layer);
					        }
					        // CEL CHUNK
					        else if (chunkType == Chunks.Cel)
					        {
					            var layer = layers[WORD()];
					            var x = SHORT();
					            var y = SHORT();
					            var alpha = BYTE() / 255f;
					            var celType = WORD();
					            var width = 0;
					            var height = 0;
					            Color[] pixels = null;
					            Cel link = null;

					            SEEK(7);

					            // RAW or DEFLATE
					            if (celType == 0 || celType == 2)
					            {
					                width = WORD();
					                height = WORD();

									// TODO: allocating the entire RGBA data may cause a stack overflow if the image is big enough?
					                var count = width * height * (int)mode;
					                if (count > temp.Count)
					                    temp = scope:: uint8[count];

					                // RAW
					                if (celType == 0)
					                {
										BYTES(temp, count);
					                }
					                // DEFLATE
					                else
					                {
										// TODO: allocating the entire deflated image might cause stack overflow if the image is big enough?
										// get the source buffer
										var source = scope::uint8[chunkEnd - stream.Position];

										// TODO: Is there some way to read more than one byte at a time from stream?
										for (int n = 0; n < source.Count; n ++)
											source[n] = stream.Read<uint8>();

										// decompress into the temp buffer
										var length = temp.Count;
										MiniZ.Uncompress(&temp[0], ref length, &source[0], source.Count);
					                }

					                // get pixel data
					                pixels = new Color[width * height];
					                BytesToPixels(temp, pixels, mode, palette);
					            }
					            // REFERENCE
					            else if (celType == 1)
					            {
					                var linkFrame = frames[WORD()];
					                var linkCel = linkFrame.[Friend]cels[frame.[Friend]cels.Count];

					                width = linkCel.Width;
					                height = linkCel.Height;
					                pixels = linkCel.Pixels;
					                link = linkCel;
					            }
					            else
									Runtime.FatalError("Cel type not yet implemented");

								var cel = new Cel(layer, pixels);
					            cel.X = x;
					            cel.Y = y;
					            cel.Width = width;
					            cel.Height = height;
					            cel.Alpha = alpha;
					            cel.Link = link;

					            // draw to frame if visible
					            if (cel.Layer.Visible)
					                CelToFrame(frame, cel);

					            frame.[Friend]cels.Add(cel);
					        }
					        // PALETTE CHUNK
					        else if (chunkType == Chunks.Palette)
					        {
					            DWORD(); //size (unused)
					            var start = DWORD();
					            var end = DWORD();
					            SEEK(8); // for future

					            for (int p = 0; p < (end - start) + 1; p++)
					            {
					                var hasName = WORD();
					                palette[start + p] = Color(BYTE(), BYTE(), BYTE(), BYTE());

					                if (Calc.BitCheck(hasName, 0))
					                    STRING(scope String());
					            }
					        }
					        // USERDATA
					        else if (chunkType == Chunks.UserData)
					        {
					            if (last != null)
					            {
					                var flags = (int)DWORD();

					                // has text
					                if (Calc.BitCheck(flags, 0))
					                    STRING(last.UserDataText);

					                // has color
					                if (Calc.BitCheck(flags, 1))
					                    last.UserDataColor = Color(BYTE(), BYTE(), BYTE(), BYTE());
					            }
					        }
					        // TAG
					        else if (chunkType == Chunks.FrameTags)
					        {
					            var count = WORD();
					            SEEK(8);

					            for (int t = 0; t < count; t++)
					            {
					                var tag = new Tag();
					                tag.From = WORD();
					                tag.To = WORD();
					                tag.LoopDirection = (Tag.LoopDirections)BYTE();
					                SEEK(8);
					                tag.Color = Color(BYTE(), BYTE(), BYTE(), (uint8)255);
					                SEEK(1);
					                STRING(tag.Name);
					                tags.Add(tag);
					            }
					        }
					        // SLICE
					        else if (chunkType == Chunks.Slice)
					        {
					            var count = DWORD();
					            var flags = (int)DWORD();
					            DWORD(); // reserved
					            var name = STRING(scope String());

					            for (int s = 0; s < count; s++)
					            {
					                var slice = new Slice();
									slice.Name.Set(name);
				                    slice.Frame = (int)DWORD();
				                    slice.OriginX = (int)LONG();
				                    slice.OriginY = (int)LONG();
				                    slice.Width = (int)DWORD();
				                    slice.Height = (int)DWORD();

					                // 9 slice (ignored atm)
					                if (Calc.BitCheck(flags, 0))
					                {
					                    slice.NineSlice = Rect(
					                        (int)LONG(),
					                        (int)LONG(),
					                        (int)DWORD(),
					                        (int)DWORD());
					                }

					                // pivot point
					                if (Calc.BitCheck(flags, 1))
					                    slice.Pivot = Point((int)DWORD(), (int)DWORD());
					                
					                slices.Add(slice);
					            }
					        }

					        stream.Position = chunkEnd;
					    }

					    stream.Position = frameEnd;
						frame.FinishLoad();
					}
				}
			}

			stream.Close();
		}

		private void BytesToPixels(uint8[] bytes, Color[] pixels, Modes mode, Color[] palette)
		{
		    int len = pixels.Count;
		    if (mode == Modes.RGBA)
		    {
		        for (int p = 0, int b = 0; p < len; p++, b += 4)
		        {
		            pixels[p].R = (uint8)((int)bytes[b + 0] * (int)bytes[b + 3] / 255);
		            pixels[p].G = (uint8)((int)bytes[b + 1] * (int)bytes[b + 3] / 255);
		            pixels[p].B = (uint8)((int)bytes[b + 2] * (int)bytes[b + 3] / 255);
		            pixels[p].A = bytes[b + 3];
		        }
		    }
		    else if (mode == Modes.Grayscale)
		    {
		        for (int p = 0, int b = 0; p < len; p++, b += 2)
		        {
		            pixels[p].R = pixels[p].G = pixels[p].B = (uint8)((int)bytes[b + 0] * (int)bytes[b + 1] / 255);
		            pixels[p].A = bytes[b + 1];
		        }
		    }
		    else if (mode == Modes.Indexed)
		    {
		        for (int p = 0;  p < len; p++)
		            pixels[p] = palette[bytes[p]];
		    }
		}

		private void CelToFrame(Frame frame, Cel cel)
		{
		    let opacity = (uint8)((cel.Alpha * cel.Layer.Alpha) * 255);

		    var blend = BlendModes[0];
		    if (cel.Layer.BlendMode < BlendModes.Count)
		        blend = BlendModes[cel.Layer.BlendMode];

		    for (int sx = Math.Max(0, -cel.X), int right = Math.Min(cel.Width, Width - cel.X); sx < right; sx++)
		    {
		        int dx = cel.X + sx;
		        int dy = cel.Y * Width;

		        for (int sy = Math.Max(0, -cel.Y), int bottom = Math.Min(cel.Height, Height - cel.Y); sy < bottom; sy++, dy += Width)
		        {
		            if (dx + dy >= 0 && dx + dy < frame.Bytes)
		                blend(frame.Pixels, (dx + dy) * 4, cel.Pixels[sx + sy * cel.Width], opacity);
		        }
		    }
		}

		// Data

		public class Frame
		{
			public SDL.Texture* Texture;
			public int Width;
			public int Height;
			public float Duration;
			public uint8* Pixels;
			public int32 BytesPerRow;
			public int32 Bytes;

			private List<Cel> cels;

			public this(int w, int h)
			{
				Texture = SDL.CreateTexture(Game.Renderer, (uint32)SDL.PIXELFORMAT_RGBA8888, (int32)SDL.TextureAccess.Streaming, (int32)w, (int32)h);
				Width = w;
				Height = h;

				void* ptr;
				SDL.LockTexture(Texture, null, out ptr, out BytesPerRow);
				Pixels = (uint8*)ptr;
				Bytes = (int32)(BytesPerRow * Height);

				cels = new List<Cel>();
			}

			public ~this()
			{
				for (let c in cels)
					delete c;
				delete cels;

				SDL.DestroyTexture(Texture);
			}

			public void FinishLoad()
			{
				SDL.UnlockTexture(Texture);
				Pixels = null;
			}
		}

		public class Tag
		{
		    public enum LoopDirections
		    {
		        Forward = 0,
		        Reverse = 1,
		        PingPong = 2
		    }

		    public String Name = new String() ~ delete _;
		    public LoopDirections LoopDirection;
		    public int From;
		    public int To;
		    public Color Color;
		}

		public class HasUserData
		{
			public String UserDataText = new String("") ~ delete _;
		    public Color UserDataColor;
		}

		private class Slice : HasUserData
		{
		    public int Frame;
		    public String Name = new String() ~ delete _;
		    public int OriginX;
		    public int OriginY;
		    public int Width;
		    public int Height;
		    public Point? Pivot;
		    public Rect? NineSlice;
		}

		private class Cel : HasUserData
		{
		    public Layer Layer;
		    public Color[] Pixels ~ delete _;
		    public Cel Link;

		    public int X;
		    public int Y;
		    public int Width;
		    public int Height;
		    public float Alpha;

		    public this(Layer layer, Color[] pixels)
		    {
		        Layer = layer;
		        Pixels = pixels;
		    }
		}

		private class Layer : HasUserData
		{
		    public enum Flags
		    {
		        Visible = 1,
		        Editable = 2,
		        LockMovement = 4,
		        Background = 8,
		        PreferLinkedCels = 16,
		        Collapsed = 32,
		        Reference = 64
		    }

		    public enum Types
		    {
		        Normal = 0,
		        Group = 1
		    }

		    public Flags Flag;
		    public Types Type;
		    public String Name = new String() ~ delete _;
		    public int ChildLevel;
		    public int BlendMode;
		    public float Alpha;
		    public bool Visible { get { return Flag.HasFlag(Flags.Visible); } }
		}

		// Blend Modes

		// More or less copied from Aseprite's source code:
		// https://github.com/aseprite/aseprite/blob/master/src/doc/blend_funcs.cpp

		private delegate void Blend(uint8* dest, int index, Color src, uint8 opacity);

		private static void Dispose()
		{
			for (let b in BlendModes)
				delete b;
			delete BlendModes;
		}

		private static readonly Blend[] BlendModes = new Blend[]
		{
		    // 0 - NORMAL
		    new (dest, index, src, opacity) =>
		    {
		        if (src.A != 0)
		        {
					int r = dest[index + 0];
					int g = dest[index + 1];
					int b = dest[index + 2];
					int a = dest[index + 3];

		            if (a == 0)
		            {
						r = src.R;
						g = src.G;
						b = src.B;
		                a = src.A;
		            }
		            else
		            {
		                int sa = MUL_UN8(src.A, opacity);
		                int ra = a + sa - MUL_UN8(a, sa);

		                r = (r + (src.R - r) * sa / ra);
		                g = (g + (src.G - g) * sa / ra);
		                b = (b + (src.B - b) * sa / ra);
						a = ra;
		            }

					dest[index + 0] = (uint8)r;
					dest[index + 1] = (uint8)g;
					dest[index + 2] = (uint8)b;
					dest[index + 3] = (uint8)a;
		        }
		    }
		};

		[Inline]
		private static int MUL_UN8(int a, int b)
		{
		    var t = (a * b) + 0x80;
		    return (((t >> 8) + t) >> 8);
		}
	}
}
