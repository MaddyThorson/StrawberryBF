using System;
namespace Strawberry
{
	/*
		Based on Matrix3x2.cs by Microsoft, under MIT license
		Source: https://github.com/microsoft/referencesource/blob/master/System.Numerics/System/Numerics/Matrix3x2.cs

		Copyright (c) Microsoft. All rights reserved.
		Licensed under the MIT license.
	*/

	public struct Matrix
	{
		static public readonly Matrix Identity = Matrix(1, 0, 0, 1, 0, 0);

		//       Row--vv--Column
		public float M11;
		public float M12;
		public float M21;
		public float M22;
		public float M31;
		public float M32;

		public this(float m11, float m12, float m21, float m22, float m31, float m32)
		{
			M11 = m11;
			M12 = m12;
			M21 = m21;
			M22 = m22;
			M31 = m31;
			M32 = m32;
		}

		public bool IsIdentity
		{
		    get
		    {
		        return M11 == 1f && M22 == 1f && // Check diagonal element first for early out.
		                            M12 == 0f &&
		               M21 == 0f &&
		               M31 == 0f && M32 == 0f;
		    }
		}

		public Vector Translation
		{
		    get
		    {
		        return .(M31, M32);
		    }

		    set mut
		    {
		        M31 = value.X;
		        M32 = value.Y;
		    }
		}

		public Vector Scale
		{
			get
			{
				return .(M11, M22);
			}

			set mut
			{
				M11 = value.X;
				M22 = value.Y;
			}	
		}

		public Vector Up
		{
			get
			{
				return .(M21, -M22);
			}

			set mut
			{
				M21 = value.X;
				M22 = -value.Y;
			}
		}

		public Vector Down
		{
			get
			{
				return .(M21, M22);
			}

			set mut
			{
				M21 = -value.X;
				M22 = value.Y;
			}
		}

		public Vector Right
		{
			get
			{
				return .(M11, -M12);
			}

			set mut
			{
				M11 = value.X;
				M12 = -value.Y;
			}
		}

		public Vector Left
		{
			get
			{
				return .(-M11, M12);
			}

			set mut
			{
				M11 = -value.X;
				M12 = value.Y;
			}
		}

		public Result<Matrix> Inverse
		{
			get => Invert(this);

			set mut
			{
				this = Invert(value);
			}
		}

		//Static Helpers

		public static Matrix CreateTranslation(Vector position)
		{
		    return Matrix(
				1, 0,
				0, 1,
				position.X, position.Y
			);
		}

		public static Matrix CreateScale(Vector scale)
		{
			return Matrix(
				scale.X, 0,
				0, scale.Y,
				0, 0
			);
		}

		public static Matrix CreateScale(Vector scale, Vector origin)
		{
			float tx = origin.X * (1 - scale.X);
			float ty = origin.Y * (1 - scale.Y);

			return Matrix(
				scale.X, 0,
				0, scale.Y,
				tx, ty
			);
		}

		public static Matrix CreateScale(float scale)
		{
			return Matrix(
				scale, 0,
				0, scale,
				0, 0
			);
		}

		public static Matrix CreateScale(float scale, Vector origin)
		{
			float tx = origin.X * (1 - scale);
			float ty = origin.Y * (1 - scale);

			return Matrix(
				scale, 0,
				0, scale,
				tx, ty
			);
		}

		public static Matrix CreateSkew(float radiansX, float radiansY)
		{
			float xTan = (float)Math.Tan(radiansX);
			float yTan = (float)Math.Tan(radiansY);

			return Matrix(
				1, yTan,
				xTan, 1,
				0, 0
			);
		}

		public static Matrix CreateSkew(float radiansX, float radiansY, Vector origin)
		{
		    float xTan = (float)Math.Tan(radiansX);
		    float yTan = (float)Math.Tan(radiansY);

		    float tx = -origin.Y * xTan;
		    float ty = -origin.X * yTan;

			return Matrix(
				1, yTan,
				xTan, 1,
				tx, ty
			);
		}

		public static Matrix CreateRotation(float radians)
		{
			let rad = (float)Math.IEEERemainder(radians, Math.PI_f * 2);

		    float c, s;

		    const float epsilon = 0.001f * (float)Math.PI_f / 180f;     // 0.1% of a degree

		    if (rad > -epsilon && rad < epsilon)
		    {
		        // Exact case for zero rotation.
		        c = 1;
		        s = 0;
		    }
		    else if (rad > Math.PI_f / 2 - epsilon && rad < Math.PI_f / 2 + epsilon)
		    {
		        // Exact case for 90 degree rotation.
		        c = 0;
		        s = 1;
		    }
		    else if (rad < -Math.PI_f + epsilon || rad > Math.PI_f - epsilon)
		    {
		        // Exact case for 180 degree rotation.
		        c = -1;
		        s = 0;
		    }
		    else if (rad > -Math.PI_f / 2 - epsilon && rad < -Math.PI_f / 2 + epsilon)
		    {
		        // Exact case for 270 degree rotation.
		        c = 0;
		        s = -1;
		    }
		    else
		    {
		        // Arbitrary rotation.
		        c = (float)Math.Cos(rad);
		        s = (float)Math.Sin(rad);
		    }

			return Matrix(
				c, s,
				-s, c,
				0, 0
			);
		}

		public static Matrix CreateRotation(float radians, Vector origin)
		{
		    let rad = (float)Math.IEEERemainder(radians, Math.PI_f * 2);

		    float c, s;

		    const float epsilon = 0.001f * (float)Math.PI_f / 180f;     // 0.1% of a degree

		    if (rad > -epsilon && rad < epsilon)
		    {
		        // Exact case for zero rotation.
		        c = 1;
		        s = 0;
		    }
		    else if (rad > Math.PI_f / 2 - epsilon && rad < Math.PI_f / 2 + epsilon)
		    {
		        // Exact case for 90 degree rotation.
		        c = 0;
		        s = 1;
		    }
		    else if (rad < -Math.PI_f + epsilon || rad > Math.PI_f - epsilon)
		    {
		        // Exact case for 180 degree rotation.
		        c = -1;
		        s = 0;
		    }
		    else if (rad > -Math.PI_f / 2 - epsilon && rad < -Math.PI_f / 2 + epsilon)
		    {
		        // Exact case for 270 degree rotation.
		        c = 0;
		        s = -1;
		    }
		    else
		    {
		        // Arbitrary rotation.
		        c = (float)Math.Cos(rad);
		        s = (float)Math.Sin(rad);
		    }

		    float x = origin.X * (1 - c) + origin.Y * s;
		    float y = origin.Y * (1 - c) - origin.X * s;

			return Matrix(
				c, s,
				-s, c,
				x, y
			);
		}

		/// Calculates the determinant for this matrix. 
		/// The determinant is calculated by expanding the matrix with a third column whose values are (0,0,1).
		public float GetDeterminant()
		{
		    // There isn't actually any such thing as a determinant for a non-square matrix,
		    // but this 3x2 type is really just an optimization of a 3x3 where we happen to
		    // know the rightmost column is always (0, 0, 1). So we expand to 3x3 format:
		    //
		    //  [ M11, M12, 0 ]
		    //  [ M21, M22, 0 ]
		    //  [ M31, M32, 1 ]
		    //
		    // Sum the diagonal products:
		    //  (M11 * M22 * 1) + (M12 * 0 * M31) + (0 * M21 * M32)
		    //
		    // Subtract the opposite diagonal products:
		    //  (M31 * M22 * 0) + (M32 * 0 * M11) + (1 * M21 * M12)
		    //
		    // Collapse out the constants and oh look, this is just a 2x2 determinant!

		    return (M11 * M22) - (M21 * M12);
		}

		public static Result<Matrix> Invert(Matrix matrix)
		{
		    let det = (matrix.M11 * matrix.M22) - (matrix.M21 * matrix.M12);

		    if (Math.Abs(det) < float.Epsilon)
				return .Err;

		    let invDet = 1.0f / det;

		    return Matrix(
				matrix.M22 * invDet,
				-matrix.M12 * invDet,

				-matrix.M21 * invDet,
				matrix.M11 * invDet,

				(matrix.M21 * matrix.M32 - matrix.M31 * matrix.M22) * invDet,
				(matrix.M31 * matrix.M12 - matrix.M11 * matrix.M32) * invDet
			);
		}

		public static Matrix Lerp(Matrix a, Matrix b, float t)
		{
			return Matrix(
				a.M11 + (b.M11 - a.M11) * t,
				a.M12 + (b.M12 - a.M12) * t,

				a.M21 + (b.M21 - a.M21) * t,
				a.M22 + (b.M22 - a.M22) * t,

				a.M31 + (b.M31 - a.M31) * t,
				a.M32 + (b.M32 - a.M32) * t
			);
		}

		public static Matrix Negate(Matrix mat)
		{
			return Matrix(
				-mat.M11, -mat.M12,
				-mat.M21, -mat.M22,
				-mat.M31, -mat.M32
			);
		}

		public static Matrix Add(Matrix a, Matrix b)
		{
			return Matrix(
				a.M11 + b.M11, a.M12 + b.M12,
				a.M21 + b.M21, a.M22 + b.M22,
				a.M31 + b.M31, a.M32 + b.M32
			);
		}

		public static Matrix Subtract(Matrix a, Matrix b)
		{
		    return Matrix(
				a.M11 - b.M11, a.M12 - b.M12,
				a.M21 - b.M21, a.M22 - b.M22,
				a.M31 - b.M31, a.M32 - b.M32
			);
		}

		public static Matrix Multiply(Matrix a, Matrix b)
		{
		    return Matrix(
				a.M11 * b.M11 + a.M12 * b.M21,
				a.M11 * b.M12 + a.M12 * b.M22,

				a.M21 * b.M11 + a.M22 * b.M21,
				a.M21 * b.M12 + a.M22 * b.M22,

				a.M31 * b.M11 + a.M32 * b.M21 + b.M31,
				a.M31 * b.M12 + a.M32 * b.M22 + b.M32
			);
		}

		public static Matrix Multiply(Matrix a, float scale)
		{
		    return Matrix(
				a.M11 * scale, a.M12 * scale,
				a.M21 * scale, a.M22 * scale,
				a.M31 * scale, a.M32 * scale
			);
		}

		// Operators

		public static Matrix operator -(Matrix mat)
		{
			return Matrix(
				-mat.M11, -mat.M12,
				-mat.M21, -mat.M22,
				-mat.M31, -mat.M32
			);
		}

		public static Matrix operator +(Matrix a, Matrix b)
		{
			return Matrix(
				a.M11 + b.M11, a.M12 + b.M12,
				a.M21 + b.M21, a.M22 + b.M22,
				a.M31 + b.M31, a.M32 + b.M32
			);
		}

		public static Matrix operator -(Matrix a, Matrix b)
		{
		    return Matrix(
				a.M11 - b.M11, a.M12 - b.M12,
				a.M21 - b.M21, a.M22 - b.M22,
				a.M31 - b.M31, a.M32 - b.M32
			);
		}

		public static Matrix operator *(Matrix a, Matrix b)
		{
		    return Matrix(
				a.M11 * b.M11 + a.M12 * b.M21,
				a.M11 * b.M12 + a.M12 * b.M22,

				a.M21 * b.M11 + a.M22 * b.M21,
				a.M21 * b.M12 + a.M22 * b.M22,

				a.M31 * b.M11 + a.M32 * b.M21 + b.M31,
				a.M31 * b.M12 + a.M32 * b.M22 + b.M32
			);
		}

		public static Matrix operator *(Matrix mat, float scale)
		{
			return Matrix(
				mat.M11 * scale, mat.M12 * scale,
				mat.M21 * scale, mat.M22 * scale,
				mat.M31 * scale, mat.M32 * scale
			);
		}

		public static bool operator ==(Matrix a, Matrix b)
		{
		    return (a.M11 == b.M11 && a.M22 == b.M22 && // Check diagonal element first for early out.
		                                        a.M12 == b.M12 &&
		            a.M21 == b.M21 &&
		            a.M31 == b.M31 && a.M32 == b.M32);
		}

		public static bool operator !=(Matrix a, Matrix b)
		{
		    return (a.M11 != b.M11 || a.M12 != b.M12 ||
		            a.M21 != b.M21 || a.M22 != b.M22 ||
		            a.M31 != b.M31 || a.M32 != b.M32);
		}

		public override void ToString(String strBuffer)
		{
			let str = scope String();

			str.Append("[ ");
			M11.ToString(str);
			str.Append(", ");
			M12.ToString(str);
			str.Append(",\n");
			M21.ToString(str);
			str.Append(", ");
			M22.ToString(str);
			str.Append(",\n");
			M31.ToString(str);
			str.Append(", ");
			M32.ToString(str);
			str.Append(" ]");
		}
	}
}
