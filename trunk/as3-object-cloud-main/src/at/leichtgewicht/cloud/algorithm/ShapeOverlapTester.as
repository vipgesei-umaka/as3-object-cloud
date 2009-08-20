package at.leichtgewicht.cloud.algorithm 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	
	/**
	 * @author Martin Heidegger
	 */
	public class ShapeOverlapTester extends Sprite 
	{
		// Rectangle to be used for every calculation
		private const HELPER_RECT: Rectangle = new Rectangle();
		
		// Matrix to be used for every calculcation
		private const HELPER_MATRIX: Matrix = new Matrix( 1, 0, 0, 1 );
		
		private const TOP_LEFT: Point = new Point();
		
		private const _size: Rectangle = new Rectangle( );
		private const _tester: BitmapData = new BitmapData( 2880, 2880, false, 0xFFFFFF );

		public function ShapeOverlapTester()
		{
			_tester.lock();
			_size.width = width;
			_size.height = height;
			with( graphics )
			{
				clear();
				beginFill( 0xFFFFFF, 1.0 );
				drawRect( -999999, -999999, 1999999, 1999999 );
				endFill();
			}
		}
		
		public function clear(): void
		{
			var i: int = numChildren;
			while( --i-(-1) )
			{
				removeChild( getChildAt(i) );
			}
		}
		
		public function test( area: Rectangle ): Boolean
		{
			HELPER_MATRIX.tx = -area.x;
			HELPER_MATRIX.ty = -area.y;
			HELPER_RECT.width = area.width;
			HELPER_RECT.height = area.height;
			_tester.draw( this, HELPER_MATRIX, null, null, HELPER_RECT, false );
			return _tester.threshold( _tester, HELPER_RECT, TOP_LEFT,
											"<=", 0xFF767676, 0xFFFF0000 ) != 0;
		}
		
		public function get bitmap(): BitmapData
		{
			return _tester;
		}
	}
}
