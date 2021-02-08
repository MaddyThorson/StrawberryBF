using System;
using Strawberry;

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
			for (let x < CellsX)
				for (let y < CellsY)
					contents[x, y] = '0';
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
				return contents[Math.Clamp(x, 0, CellsX - 1), Math.Clamp(y, 0, CellsY - 1)];
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
				return this[p.X, p.Y];
			}

			[Inline]
			set
			{
				this[p.X, p.Y] = value;
			}
		}

		public void Set(Rect r, char8 val)
		{
			for (let x < r.Width)
				for (let y < r.Height)
					contents[r.X + x, r.Y + y] = val;
		}

		public int CellsX => contents.GetLength(0);
		public int CellsY => contents.GetLength(1);

		//Expand Edges

		public enum ExpandDirections { Left, Right, Up, Down };

		public void ExpandEdge(ExpandDirections direction, int add = 1)
		{
			Runtime.Assert(add > 0);

			char8[,] newContents;
			if (direction == .Left || direction == .Right)
				newContents = new char8[CellsX + add, CellsY];
			else
				newContents = new char8[CellsX, CellsY + add];

			switch (direction)
			{
			case .Left:
				Offset.X -= CellSize.X * add;
				for (let x < CellsX)
					for (let y < CellsY)
						newContents[x + add, y] = contents[x, y];
				for (let x < add)
					for (let y < CellsY)
						newContents[x, y] = contents[0, y];

			case .Right:
				for (let x < CellsX)
					for (let y < CellsY)
						newContents[x, y] = contents[x, y];
				for (let x < add)
					for (let y < CellsY)
						newContents[CellsX + x, y] = contents[CellsX - 1, y];

			case .Up:
				Offset.Y -= CellSize.Y * add;
				for (let x < CellsX)
					for (let y < CellsY)
						newContents[x, y + add] = contents[x, y];
				for (let x < CellsX)
					for (let y < add)
						newContents[x, y] = contents[x, 0];

			case .Down:
				for (let x < CellsX)
					for (let y < CellsY)
						newContents[x, y] = contents[x, y];
				for (let x < CellsX)
					for (let y < add)
						newContents[x, CellsY + y] = contents[x, CellsY - 1];
			}

			delete contents;
			contents = newContents;
		}

		//Collision Checks

		public bool IsInBounds(Point p)
		{
			return p.X >= 0 && p.Y >= 0 && p.X < CellsX && p.Y < CellsY;
		}

		public bool Check(Hitbox hitbox)
		{
			return Check(hitbox.SceneHitbox);
		}

		public bool Check(IHasHitbox other)
		{
			return Check(other.Hitbox.SceneHitbox);
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
					if (this[p] != '0')
						return true;
				}
			}

			return false;
		}

		public bool Check(Point point)
		{
			Point check = (point - Offset) / CellSize;
			return this[check] != '0';
		}

		public void Draw(Color color)
		{
			for (let x < CellsX)
				for (let y < CellsY)
					if (this[x, y] != '0')
						Game.Batcher.Rect(Rect(x, y, 1, 1) * CellSize + Offset, color);
		}
	}
}
