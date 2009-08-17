package at.leichtgewicht.util 
{
	import flash.geom.Rectangle;

	import at.leichtgewicht.cloud.PositionEvent;
	import at.leichtgewicht.cloud.ObjectCloud;
	import flash.display.Sprite;

	
	/**
	 * @author Martin Heidegger
	 */
	public class SizeFitter extends Sprite 
	{
		private var _cloud: ObjectCloud;
		private var _targetWidth: Number = 250;
		
		public function SizeFitter( cloud: ObjectCloud )
		{
			addChild( _cloud = cloud );
			_cloud.addEventListener( PositionEvent.NEXT_POSITION_FOUND, onPositionFound );
		}
		
		private function onPositionFound(event: PositionEvent): void
		{
			_cloud.width = _targetWidth;
			_cloud.scaleY = _cloud.scaleX;
			var bounds: Rectangle = _cloud.getBounds( _cloud );
			_cloud.x = -bounds.x;
			_cloud.y = -bounds.y;
		}
		
		public function get targetWidth(): Number
		{
			return _targetWidth;
		}
	}
}
