package at.leichtgewicht.cloud 
{
	import flash.filters.GlowFilter;

	import at.leichtgewicht.cloud.IShapeSet;
	import at.leichtgewicht.draw.Star;

	import flash.display.DisplayObject;
	import flash.display.Shape;

	
	/**
	 * @author Martin Heidegger
	 */
	public class StarSet implements IShapeSet 
	{
		private var _shape: Shape;
		private var _object: Shape;

		public function StarSet( innerRadius: Number, outerRadius: Number, color: int, amountCorners: int, angle: Number, safetyBorder: Number )
		{
			_object = new Shape();
			_object.graphics.beginFill( color, 1.0 );
			Star.drawStar( _object.graphics, innerRadius, outerRadius, amountCorners, angle );
			_shape = new Shape();
			_shape.graphics.beginFill( 0x000000, 1.0 );
			Star.drawStar( _shape.graphics, innerRadius+safetyBorder, outerRadius+safetyBorder, amountCorners, angle );
		}
		
		public function get object(): DisplayObject
		{
			return _object;
		}
		
		public function get shape(): DisplayObject
		{
			return _shape;
		}
	}
}
