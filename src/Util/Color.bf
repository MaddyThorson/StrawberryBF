using System;

namespace Strawberry
{
	public struct Color
	{
		static public readonly Color White = Color(255, 255, 255);
		static public readonly Color Black = Color(0, 0, 0);
		static public readonly Color Transparent = Color(0, 0, 0, 0);
		static public readonly Color Red = Color(255, 0, 0);
		static public readonly Color Green = Color(0, 255, 0);
		static public readonly Color Blue = Color(0, 0, 255);

		public uint8 R;
		public uint8 G;
		public uint8 B;
		public uint8 A;

		public this(uint8 red, uint8 green, uint8 blue, uint8 alpha)
		{
			R = red;
			G = green;
			B = blue;
			A = alpha;
		}

		public this(uint8 red, uint8 green, uint8 blue)
			: this(red, green, blue, 255)
		{

		}

		public this(float red, float green, float blue, float alpha)
		{
			R = (uint8)(red * 255);
			G = (uint8)(green * 255);
			B = (uint8)(blue * 255);
			A = (uint8)(alpha * 255);
		}

		public this(float red, float green, float blue)
			: this(red, green, blue, 1f)
		{

		}

		public float Rf
		{
			[Inline]
			get
			{
				return R / 255f;
			}

			[Inline]
			set	mut
			{
				R = (uint8)(value * 255);
			}
		}

		public float Gf
		{
			[Inline]
			get
			{
				return G / 255f;
			}

			[Inline]
			set	mut
			{
				G = (uint8)(value * 255);
			}
		}

		public float Bf
		{
			[Inline]
			get
			{
				return B / 255f;
			}

			[Inline]
			set	mut
			{
				B = (uint8)(value * 255);
			}
		}

		public float Af
		{
			[Inline]
			get
			{
				return A / 255f;
			}

			[Inline]
			set	mut
			{
				A = (uint8)(value * 255);
			}
		}

		static public Color Lerp(Color a, Color b, float t)
		{
			return Color(
				Math.Lerp(a.Rf, b.Rf, t),
				Math.Lerp(a.Gf, b.Gf, t),
				Math.Lerp(a.Bf, b.Bf, t),
				Math.Lerp(a.Af, b.Af, t)
			);
		}

		static public Color operator/(Color a, Color b)
		{
			return Lerp(a, b, 0.5f);
		}

		static public Color operator*(Color color, float b)
		{
			return Color(color.R, color.G, color.B, (uint8)(color.A * b));
		}

		static public implicit operator SDL2.SDL.Color(Color color)
		{
			return SDL2.SDL.Color(color.R, color.G, color.B, color.A);
		}
	}
}
