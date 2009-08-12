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
	import at.leichtgewicht.util.IClonableDisplayObject;
	
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;	

	/**
	 * @author Martin Heidegger
	 * @version 1.0
	 */
	public class TextDrawing extends Sprite implements IClonableDisplayObject
	{
		private var _tf: TextField;
		private var _text: String;
		private var _size: Number;
		private var _safetyBorder: Number;
		private var _rotation: Number;
		private var _fontName: String;
		private var _embeddedFont: Boolean;

		public function TextDrawing( fontName: String, embeddedFont: Boolean, text: String, safetyBorder: Number, size: Number, rotation: Number )
		{
			_text = text;
			_fontName = fontName;
			_embeddedFont = embeddedFont,
			_safetyBorder = safetyBorder;
			_rotation = rotation;
			_size = size;
			_tf = createTextField( fontName, embeddedFont, text, size, rotation );
			_tf.x = -_tf.width/2;
			_tf.y = -_tf.height/2;
			alpha = 0.5;
			filters = [ new GlowFilter( 0x000000, 1, safetyBorder, safetyBorder, 255 ) ];
			cacheAsBitmap = true;
			
			addChild( _tf );
		}

		public function createTextField( fontName: String, embeddedFont: Boolean, text: String, size: Number, rotation: Number ): TextField
		{
			var result: TextField = new TextField();
			result.embedFonts = embeddedFont;
			result.textColor = 0x000000;
			result.antiAliasType = AntiAliasType.ADVANCED;
			result.text = text;
			result.setTextFormat( new TextFormat( fontName, size ) );
			result.autoSize = TextFieldAutoSize.LEFT;
			result.background = false;
			result.selectable = false;
			result.rotation = rotation;
			return result;
		}
		
		public function get size(): Number
		{
			return _tf.width * _tf.height;
		}
		
		public function clone(): IClonableDisplayObject
		{
			var result: TextDrawing = new TextDrawing( _fontName, _embeddedFont, _text, _safetyBorder, _size, _rotation );
			result.x = x;
			result.y = y;
			result.alpha = alpha;
			result.scaleX = scaleX;
			result.scaleY = scaleY;
			result.rotation = rotation;
			return result;
		}
	}
}
