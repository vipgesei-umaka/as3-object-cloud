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
package at.leichtgewicht.cloud.algorithm 
{
	import at.leichtgewicht.util.AdvancedHitTest;
	
	import de.polygonal.math.PM_PRNG;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;	

	/**
	 * @author Martin Heidegger
	 * @version 1.0
	 */
	public class CirclePositionAlgorithm extends AbstractStraightPositionAlogrithm
	{
		private var _container: Sprite;
		private var _tries: Number;
		private var _currentRadius: Number;
		private var _currentFactor: Number;
		private var _prng: PM_PRNG;
		private var _currentChild: DisplayObject;
		private var _currentChildPos: Point;
		private var _currentChildStartX: Number;
		private var _currentChildStartY: Number;
		private var _currentBounds: Rectangle;
		private var _currentAngle: Number;
		private var _sizeWeight: Number = 0.8;
		private var _radiusStep: Number = 15;
		private var _minTries: Number = 1;
		private var _triesPerRadius: Number = 6;
		private var _reuseFormerPosition: Boolean = false;
		private var _relativeAngle: Boolean = false;
		
		public function CirclePositionAlgorithm()
		{
			super();
			_currentChildPos = new Point();
		}
		
		override protected function clear(): void
		{
			super.clear();
			_container = new Sprite();
			_prng = new PM_PRNG( );
			_currentChild = null;
			_currentRadius = 0;
			_currentAngle = 0;
			_tries = 0;
		}
		
		override protected function tryNextPosition( offset: Point ): Boolean
		{
			if( _tries > ( _minTries + _currentRadius / _triesPerRadius ) )
			{
				_tries = 0;
				_currentRadius += _radiusStep + _currentFactor * _prng.nextDouble();
			}
			_tries ++;
			
			var angle: Number = ( _prng.nextDouble() * 360 ) % 360;
			var factor: Number = _sizeWeight + ( 1 - _sizeWeight ) * _currentChild.width/_currentChild.height;
			var x: Number = offset.x * ( _currentChildStartX + Math.cos( angle / 180 * Math.PI ) * _currentRadius * factor );
			var y: Number = offset.y * ( _currentChildStartY + Math.sin( angle / 180 * Math.PI ) * _currentRadius / factor );
			
			_currentChild.x = x;
			_currentChild.y = y;
			_currentBounds.x = _currentChildPos.x + x;
			_currentBounds.y = _currentChildPos.y + y;
			
			return AdvancedHitTest.darkDetection( _container, _currentBounds );
		}
		
		override protected function set current( current: DisplayObject ): void
		{
			_currentChildStartX = 0;
			_currentChildStartY = 0;
				
			if( null != _currentChild && _reuseFormerPosition )
			{
				_currentChildStartX = _currentChild.x;
				_currentChildStartY = _currentChild.y;
			}
			
			_currentChild = current;
			_currentChild.alpha = 0.5;
			
			_container.addChild( _currentChild );
			
			_currentFactor = Math.sqrt( _currentChild.height / _currentChild.width );
			
			_currentBounds = _currentChild.getBounds( _container );
			_currentChildPos.x = _currentBounds.x;
			_currentChildPos.y = _currentBounds.y;
			
			_currentChild.x = _currentChildStartX;
			_currentChild.y = _currentChildStartY;

			if( _relativeAngle )
			{
				_currentAngle += Math.PI / 4;
				var max: Number = Math.PI * 2;
				if( _currentAngle >= max )
				{
					_currentAngle -= max;
				}
			}
			else
			{
				_currentAngle = 2 * Math.PI * _prng.nextDouble();
			}
		
			
			_currentRadius = 5;
			_tries = 0;
		}
		
		public function set sizeWeight(sizeWeight: Number): void
		{
			_sizeWeight = sizeWeight;
		}
		
		public function set radiusStep(radiusStep: Number): void
		{
			_radiusStep = radiusStep;
		}
		
		public function set minTries(minTries: Number): void
		{
			_minTries = minTries;
		}
		
		public function set triesPerRadius(triesPerRadius: Number): void
		{
			_triesPerRadius = triesPerRadius;
		}
		
		public function set reuseFormerPosition(reuseFormerPosition: Boolean): void
		{
			_reuseFormerPosition = reuseFormerPosition;
		}
		
		public function get relativeAngle(): Boolean
		{
			return _relativeAngle;
		}
		
		public function set relativeAngle(relativeAngle: Boolean): void
		{
			_relativeAngle = relativeAngle;
		}
	}
}
