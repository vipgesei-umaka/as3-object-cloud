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
	import at.leichtgewicht.cloud.algorithm.IPositionAlgorithm;
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	
	/**
	 * @author Martin Heidegger
	 * @version 1.0
	 */
	public class ObjectCloud extends Sprite
	{
		private var _container: Sprite;
		private var _strategy: IPositionAlgorithm;
		private var _objects: Array;

		public function ObjectCloud() {}
		
		public function set objects( objects: Array ): void
		{
			_objects = objects;
			clear();
		}
		
		public function get objects(): Array
		{
			return _objects;
		}
		
		public function set strategy(strategy: IPositionAlgorithm): void
		{
			if( _strategy )
			{
				_strategy.removeEventListener( RenderProgressEvent.UPDATE, onPositionEvent );
			}
			_strategy = strategy;
			if( _strategy )
			{
				_strategy.addEventListener( RenderProgressEvent.UPDATE, onPositionEvent );
			}
			clear();
		}
		
		public function get strategy(): IPositionAlgorithm
		{
			return _strategy;
		}
		
		public function get percentage(): Number
		{
			return _strategy.percentage;
		}
		
		private function clear(): void
		{
			if( _container )
			{
				removeChild( _container );
			}
			addChild( _container = new Sprite() );
			if( _strategy && _objects )
			{
				_strategy.drawObjects( _objects );
			}
		}
		
		private function onPositionEvent( event: RenderProgressEvent ): void
		{
			if( event.positionatedObject )
			{
				var object: DisplayObject = DisplayObject( event.positionatedObject.clone() );
				object.filters = null;
				object.alpha = 1;
				_container.addChild( object );
			}
			dispatchEvent( new RenderProgressEvent( event.type, event.percentage, event.positionatedObject ) );
		}
	}
}