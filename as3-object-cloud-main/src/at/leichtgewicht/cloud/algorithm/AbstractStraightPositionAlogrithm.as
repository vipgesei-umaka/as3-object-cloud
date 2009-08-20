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
	import at.leichtgewicht.cloud.RenderProgressEvent;
	import at.leichtgewicht.util.IClonableDisplayObject;

	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	
	/**
	 * @author Martin Heidegger
	 * @version 1.0
	 */
	public class AbstractStraightPositionAlogrithm extends EventDispatcher implements IPositionAlgorithm
	{
		private var _percentage: Number;
		private var _rawObjects: Array;
		private var _currentObjectNo: Number = 0;
		private var _timer: Timer;
		private var _current: IClonableDisplayObject;

		public function AbstractStraightPositionAlogrithm()
		{
			_timer = new Timer( Number.MIN_VALUE );
			_timer.addEventListener( TimerEvent.TIMER, nextTry );
		}
		
		public function drawObjects( rawObjects: Array ): void
		{
			_percentage = 0;
			_currentObjectNo = 0;
			_rawObjects = rawObjects;
			_current = rawObjects[ 0 ];
			
			clear();
			
			_timer.stop();
			_timer.reset();
			_timer.start( );
			
			nextTry( );
		}
		
		public function get percentage(): Number
		{
			return _percentage;
		}
		
		protected function clear(): void
		{
		}
		
		protected function tryNextPosition(): Boolean
		{
			throw new Error( "not implemented" );
		}
		
		protected function set current( current: DisplayObject ): void
		{
			throw new Error( "not implemented" );
		}
		
		private function finish(): void
		{
			_timer.stop();
		}
		
		private function nextChild(): Boolean
		{
			var formerObject: IClonableDisplayObject = _current;
			var finished: Boolean = false;
			
			_currentObjectNo ++;
			_percentage = _currentObjectNo / _rawObjects.length;
			
			if( _currentObjectNo > _rawObjects.length-1 )
			{
				finish();
				finished = true;
			}
			else
			{
				current = DisplayObject( _current = IClonableDisplayObject( _rawObjects[ _currentObjectNo ] ) );
			}
			
			dispatchEvent( new RenderProgressEvent( RenderProgressEvent.UPDATE, _percentage, formerObject ) );
			
			return finished;
		}
		
		private function nextTry( event: TimerEvent = null ): void
		{
			const executionStartTime: int = getTimer();
			if( _currentObjectNo == 0 )
			{
				current = DisplayObject( _current );
				nextChild();
			}
			while( true )
			{
				if( !tryNextPosition() )
				{
					if( nextChild() )
					{
						return;
					}
				}
				if( getTimer() - executionStartTime > 80 )
				{
					return;
				}
			}
		}
	}
}
