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
package at.leichtgewicht.cloud 
{
	import de.polygonal.math.PM_PRNG;	
	
	/**
	 * @author Martin Heidegger
	 * @version 1.0
	 */
	public class TagCloud extends ObjectCloud
	{
		public function drawText( text: String, algorithm: IPositionAlgorithm, textRenderer: ITextRenderer, shuffle: Boolean = true ): void
		{
			var prng: PM_PRNG = new PM_PRNG();
			var weights: Array = new WeightedWords( text ).getWordWeightsSorted();
			var drawings: Array = [];
			for each ( var weightedWord: WeightedWord in weights )
			{
				drawings.push( textRenderer.render( weightedWord ) );
			}
			if( shuffle )
			{
				drawings = shuffleArray( drawings, prng );
			}
			draw( drawings, algorithm );
		}
		
		private function shuffleArray( array: Array, prng: PM_PRNG ): Array
		{
			var newDrawings: Array = [];
			while( array.length > 0 )
			{
				newDrawings.push( array.splice( int( prng.nextDouble() * array.length-1 ), 1 )[0] );
			}
			return newDrawings;
		}
	}
}
