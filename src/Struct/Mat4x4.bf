using System;

namespace Strawberry
{
	/*
		Based on Matrix3x2.cs by Microsoft, under MIT license
		Source: https://github.com/microsoft/referencesource/blob/master/System.Numerics/System/Numerics/Matrix4x4.cs

		Copyright (c) Microsoft. All rights reserved.
		Licensed under the MIT license.
	*/


	[Ordered, Packed, CRepr]
	public struct Mat4x4
	{
		static public readonly Mat4x4 Identity = Mat4x4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);

		public float[16] Values = .(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

		public this(float m11, float m12, float m13, float m14,
			float m21, float m22, float m23, float m24,
			float m31, float m32, float m33, float m34,
			float m41, float m42, float m43, float m44)
		{
			Values = .(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44);
		}

		public this()
		{

		}

		public float M11
		{
			get => Values[0];
			set mut => Values[0] = value;
		}

		public float M12
		{
			get => Values[1];
			set mut => Values[1] = value;
		}

		public float M13
		{
			get => Values[2];
			set mut => Values[2] = value;
		}

		public float M14
		{
			get => Values[3];
			set mut => Values[3] = value;
		}

		public float M21
		{
			get => Values[4];
			set mut => Values[4] = value;
		}

		public float M22
		{
			get => Values[5];
			set mut => Values[5] = value;
		}

		public float M23
		{
			get => Values[6];
			set mut => Values[6] = value;
		}

		public float M24
		{
			get => Values[7];
			set mut => Values[7] = value;
		}

		public float M31
		{
			get => Values[8];
			set mut => Values[8] = value;
		}

		public float M32
		{
			get => Values[9];
			set mut => Values[9] = value;
		}

		public float M33
		{
			get => Values[10];
			set mut => Values[10] = value;
		}

		public float M34
		{
			get => Values[11];
			set mut => Values[11] = value;
		}

		public float M41
		{
			get => Values[12];
			set mut => Values[12] = value;
		}

		public float M42
		{
			get => Values[13];
			set mut => Values[13] = value;
		}

		public float M43
		{
			get => Values[14];
			set mut => Values[14] = value;
		}

		public float M44
		{
			get => Values[15];
			set mut => Values[15] = value;
		}

		static public Mat4x4 CreateTranslation(Vector3 pos)
		{
		    return .(
				1, 0, 0, 0,
				0, 1, 0, 0,
				0, 0, 1, 0,
				pos.X, pos.Y, pos.Z, 1
			);
		}

		public static Mat4x4 CreateScale(Vector3 scale)
		{
			return .(
				scale.X, 0, 0, 0,
				0, scale.Y, 0, 0,
				0, 0, scale.Z, 0,
				0, 0, 0, 1
			);
		}

		public static Mat4x4 CreateScale(Vector3 scale, Vector3 origin)
		{
			float tx = origin.X * (1 - scale.X);
			float ty = origin.Y * (1 - scale.Y);
			float tz = origin.Z * (1 - scale.Z);

			return .(
				scale.X, 0, 0, 0,
				0, scale.Y, 0, 0,
				0, 0, scale.Z, 0,
				tx, ty, tz, 1
			);
		}

		public static Mat4x4 CreateRotationX(float radians)
		{

		    float c = (float)Math.Cos(radians);
		    float s = (float)Math.Sin(radians);

		    // [  1  0  0  0 ]
		    // [  0  c  s  0 ]
		    // [  0 -s  c  0 ]
		    // [  0  0  0  1 ]
			return .(
				1, 0, 0, 0,
				0, c, s, 0,
				0, -s, c, 0,
				0, 0, 0, 1
			);
		}

		public static Mat4x4 CreateRotationX(float radians, Vector3 origin)
		{
		    float c = (float)Math.Cos(radians);
		    float s = (float)Math.Sin(radians);

		    float y = origin.Y * (1 - c) + origin.Z * s;
		    float z = origin.Z * (1 - c) - origin.Y * s;

		    // [  1  0  0  0 ]
		    // [  0  c  s  0 ]
		    // [  0 -s  c  0 ]
		    // [  0  y  z  1 ]
			return .(
				1, 0, 0, 0,
				0, c, s, 0,
				0, -s, c, 0,
				0, y, z, 1
			);
		}

		public static Mat4x4 CreateRotationY(float radians)
		{
		    float c = (float)Math.Cos(radians);
		    float s = (float)Math.Sin(radians);

		    // [  c  0 -s  0 ]
		    // [  0  1  0  0 ]
		    // [  s  0  c  0 ]
		    // [  0  0  0  1 ]
			return .(
				c, 0, -s, 0,
				0, 1, 0, 0,
				s, 0, c, 0,
				0, 0, 0, 1
			);
		}

		public static Mat4x4 CreateRotationY(float radians, Vector3 origin)
		{
		    float c = (float)Math.Cos(radians);
		    float s = (float)Math.Sin(radians);

		    float x = origin.X * (1 - c) - origin.Z * s;
		    float z = origin.Z * (1 - c) + origin.X * s;

		    // [  c  0 -s  0 ]
		    // [  0  1  0  0 ]
		    // [  s  0  c  0 ]
		    // [  x  0  z  1 ]
			return .(
				c, 0, -s, 0,
				0, 1, 0, 0,
				s, 0, c, 0,
				x, 0, z, 1
			);
		}

		public static Mat4x4 CreateRotationZ(float radians)
		{
		    float c = (float)Math.Cos(radians);
		    float s = (float)Math.Sin(radians);

		    // [  c  s  0  0 ]
		    // [ -s  c  0  0 ]
		    // [  0  0  1  0 ]
		    // [  0  0  0  1 ]
			return .(
				c, s, 0, 0,
				-s, c, 0, 0,
				0, 0, 1, 0,
				0, 0, 0, 1
			);
		}

		public static Mat4x4 CreateRotationZ(float radians, Vector3 centerPoint)
		{
		    float c = (float)Math.Cos(radians);
		    float s = (float)Math.Sin(radians);

		    float x = centerPoint.X * (1 - c) + centerPoint.Y * s;
		    float y = centerPoint.Y * (1 - c) - centerPoint.X * s;

		    // [  c  s  0  0 ]
		    // [ -s  c  0  0 ]
		    // [  0  0  1  0 ]
		    // [  x  y  0  1 ]
			return .(
				c, s, 0, 0,
				-s, c, 0, 0,
				0, 0, 1, 0,
				x, y, 0, 1
			);
		}

		public static Mat4x4 CreateOrthographic(float width, float height, float zNearPlane, float zFarPlane)
		{
			return .(
				2 / width, 0, 0, 0,
				0, 1 / height, 0, 0,
				0, 0, 1 / (zNearPlane - zFarPlane), 0,
				0, zNearPlane / (zNearPlane - zFarPlane), 0, 1
			);
		}

		static public implicit operator Mat4x4(Mat3x2 mat)
		{
			return Mat4x4(
				mat.M11, mat.M12, 0, 0,
				mat.M21, mat.M22, 0, 0,
				0, 0, 1, 0,
				mat.M31, mat.M32, 0, 1
			);
		}

		static public Mat4x4 operator *(Mat4x4 a, Mat4x4 b)
		{
			Mat4x4 m = .();

			// First row
			m.M11 = a.M11 * b.M11 + a.M12 * b.M21 + a.M13 * b.M31 + a.M14 * b.M41;
			m.M12 = a.M11 * b.M12 + a.M12 * b.M22 + a.M13 * b.M32 + a.M14 * b.M42;
			m.M13 = a.M11 * b.M13 + a.M12 * b.M23 + a.M13 * b.M33 + a.M14 * b.M43;
			m.M14 = a.M11 * b.M14 + a.M12 * b.M24 + a.M13 * b.M34 + a.M14 * b.M44;

			// Second row
			m.M21 = a.M21 * b.M11 + a.M22 * b.M21 + a.M23 * b.M31 + a.M24 * b.M41;
			m.M22 = a.M21 * b.M12 + a.M22 * b.M22 + a.M23 * b.M32 + a.M24 * b.M42;
			m.M23 = a.M21 * b.M13 + a.M22 * b.M23 + a.M23 * b.M33 + a.M24 * b.M43;
			m.M24 = a.M21 * b.M14 + a.M22 * b.M24 + a.M23 * b.M34 + a.M24 * b.M44;

			// Third row
			m.M31 = a.M31 * b.M11 + a.M32 * b.M21 + a.M33 * b.M31 + a.M34 * b.M41;
			m.M32 = a.M31 * b.M12 + a.M32 * b.M22 + a.M33 * b.M32 + a.M34 * b.M42;
			m.M33 = a.M31 * b.M13 + a.M32 * b.M23 + a.M33 * b.M33 + a.M34 * b.M43;
			m.M34 = a.M31 * b.M14 + a.M32 * b.M24 + a.M33 * b.M34 + a.M34 * b.M44;

			// Fourth row
			m.M41 = a.M41 * b.M11 + a.M42 * b.M21 + a.M43 * b.M31 + a.M44 * b.M41;
			m.M42 = a.M41 * b.M12 + a.M42 * b.M22 + a.M43 * b.M32 + a.M44 * b.M42;
			m.M43 = a.M41 * b.M13 + a.M42 * b.M23 + a.M43 * b.M33 + a.M44 * b.M43;
			m.M44 = a.M41 * b.M14 + a.M42 * b.M24 + a.M43 * b.M34 + a.M44 * b.M44;

			return m;
		}
	}
}
