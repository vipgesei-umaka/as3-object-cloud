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
package at.leichtgewicht.cloud.text
{
	import Boolean;
	import Number;
	import String;
	import at.leichtgewicht.cloud.IShapeSet;

	import flash.display.DisplayObject;
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
	public class TextSet implements IShapeSet
	{
		private var _object: DisplayObject;
		private var _shape: DisplayObject;
		
		public function TextSet( fontName: String, embeddedFont: Boolean, text: String, safetyBorder: Number, size: Number, rotation: Number )
		{
			_object = createTextField( fontName, embeddedFont, text, size, rotation );
			_shape =  createTextField( fontName, embeddedFont, text, size, rotation );
			_shape.filters = [ new GlowFilter( 0x000000, 1, safetyBorder, safetyBorder, 255 ) ];
		}
		
		private function createTextField( fontName: String, embeddedFont: Boolean, text: String, size: Number, rotation: Number ): DisplayObject
		{
			var sprite: Sprite = new Sprite();
			var textField: TextField = new TextField();
			textField.embedFonts = embeddedFont;
			textField.textColor = 0x000000;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.text = text;
			textField.setTextFormat( new TextFormat( fontName, size ) );
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.background = false;
			textField.selectable = false;
			textField.rotation = rotation;
			textField.x = -textField.width/2;
			textField.y = -textField.height/2;
			textField.cacheAsBitmap = true;
			sprite.addChild( textField );
			return sprite;
		}
		
		public function get shape(): DisplayObject
		{
			return _shape;
		}
		
		public function get object(): DisplayObject
		{
			return _object;
		}
	}
}
