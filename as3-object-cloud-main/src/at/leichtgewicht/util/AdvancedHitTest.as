//
// (BSD License) 100% Open Source see http://en.wikipedia.org/wiki/BSD_licenses
//
// Copyright (c) 2009, Martin Heidegger
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//    * Neither the name of the Martin Heidegger nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
package at.leichtgewicht.util
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * <code>AdvancedHitTest</code> is a util to perform high speed hit tests.
	 * 
	 * @author Martin Heidegger
	 * @version 1.0
	 */
	public class AdvancedHitTest
	{
		// Instance for a 0/0 Point, used in further calculation
		private static const TOP_LEFT: Point = new Point( 0, 0 );
		
		// Matrix to be used for every calculcation
		private static const MATRIX : Matrix = new Matrix( 1, 0, 0, 1 );
		
		// Rectangle to be used for every calculation
		private static const HELPER_RECT: Rectangle = new Rectangle();
		
		// BitmapData to perform the overlapping test if no seperate is given
		private static const HELPER_BITMAP_DATA: BitmapData = new BitmapData( 2880, 2880 );
		
		/**
		 * Verifies if in a display object is a dark Area.
		 * 
		 * <p>To make proper use of this function you have to use objects of 0.5
		 * alpha inside a display object. If two objects with this 0.5 alpha overlap
		 * it will respond with <code>true</code> because the area will be dark
		 * enough to be catched.</p>
		 * 
		 * <p>If you pass-in a <code>cropRect</code> then it can be a major performance
		 * boost. It is useful to pass-in a rectangle if you know that only certain
		 * parts of your display object changed but not all. For sure this rectangle
		 * should be smaller and with the <code>object</code> bounds.</p>
		 * 
		 * <p>It might be useful for debugging if you pass-in your own <code>BitmapData</code>
		 * to make it the work of the algorithm visible.</p>
		 * 
		 * @param object <code>DisplayObject</code> to be analysed
		 * @param cropRect Rectangle to work only with certain area (if not passed-in,
		 * 			the objects bounds will be used)
		 * @param helperBitmap <code>BitmapData</code> to be used for the process. (if not passed-in,
		 * 			internal <code>BitmapData</code> will be used.
		 */
		public static function darkDetection( object: DisplayObject,
			cropRect: Rectangle = null, helperBitmap: BitmapData = null ): Boolean
		{
			if( null == cropRect )
			{
				cropRect = object.getBounds( object );
			}
			
			if( null == helperBitmap )
			{
				helperBitmap = HELPER_BITMAP_DATA;
			}
			
			HELPER_RECT.width = cropRect.width;
			HELPER_RECT.height = cropRect.height;
			
			helperBitmap.fillRect( HELPER_RECT, 0xFFFFFFFF );
			
			MATRIX.translate( -cropRect.x, -cropRect.y );
			helperBitmap.draw( object, MATRIX, null, null, HELPER_RECT );
			MATRIX.translate( cropRect.x, cropRect.y );
			
			return helperBitmap.threshold( helperBitmap, HELPER_RECT, TOP_LEFT,
											"<=", 0xFF767676, 0xFFFF0000 ) != 0;
		}
	}
}
