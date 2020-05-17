using System;

namespace Strawberry
{
	public class Grid
	{
		public Point CellSize;
		public Point Offset;

		private char8[,] contents ~ delete _;

		public this(int cellWidth, int cellHeight, int cellsX, int cellsY, int offsetX = 0, int offsetY = 0)
		{
			CellSize = .(cellWidth, cellHeight);
			Offset = .(offsetX, offsetY);

			contents = new char8[cellsX, cellsY]; 
		}

		public this(JSON ogmoJson)
			: this(ogmoJson["gridCellWidth"], ogmoJson["gridCellHeight"], ogmoJson["gridCellsX"], ogmoJson["gridCellsY"], ogmoJson["offsetX"], ogmoJson["offsetY"])
		{
			var x = 0;
			var y = 0;
			let data = ogmoJson["grid"];

			for (let i < data.ArrayLength)
			{
				contents[x, y] = data[i];

				x++;
				if (x >= contents.GetLength(0))
				{
					x = 0;
					y++;
				}
			}
		}

		public char8 this[int x, int y]
		{
			[Inline]
			get 
			{
				return contents[x, y];
			}

			[Inline]
			set
			{
				contents[x, y] = value;
			}
		}

		public char8 this[Point p]
		{
			[Inline]
			get 
			{
				return contents[p.X, p.Y];
			}

			[Inline]
			set
			{
				contents[p.X, p.Y] = value;
			}
		}

		public int CellsX => contents.GetLength(0);
		public int CellsY => contents.GetLength(1);

		public bool IsInBounds(Point p)
		{
			return p.X >= 0 && p.Y >= 0 && p.X < CellsX && p.Y < CellsY;
		}

		public bool Check(Entity entity)
		{
			return Check(entity.SceneHitbox);
		}

		public bool Check(Rect rect)
		{
			Point from = .(
				(int)Math.Floor((rect.X - Offset.X) / (float)CellSize.X),
				(int)Math.Floor((rect.Y - Offset.Y) / (float)CellSize.Y)
			);
			Point to = .(
				(int)Math.Ceiling((rect.Right - Offset.X) / (float)CellSize.X),
				(int)Math.Ceiling((rect.Bottom - Offset.Y) / (float)CellSize.Y)
			);

			for (int x = from.X; x < to.X; x++)
			{
				for (int y = from.Y; y < to.Y; y++)
				{
					let p = Point(x, y);
					if (IsInBounds(p) && this[p] != '0')
						return true;
				}
			}

			return false;
		}

		public bool Check(Point point)
		{
			Point check = (point - Offset) / CellSize;
			return IsInBounds(check) && this[check] != '0';
		}

		public void Draw(Color color)
		{
			for (let x < CellsX)
				for (let y < CellsY)
					if (this[x, y] != '0')
						Draw.Rect(Rect(x, y, 1, 1) * CellSize + Offset, color);
		}
	}
}
