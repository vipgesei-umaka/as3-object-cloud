package at.leichtgewicht.cloud.tool 
{
	import flash.geom.Rectangle;

	import at.leichtgewicht.cloud.RenderProgressEvent;
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
			_cloud.addEventListener( RenderProgressEvent.UPDATE, onPositionFound );
		}
		
		private function onPositionFound(event: RenderProgressEvent): void
		{
			_cloud.width = _targetWidth;
			_cloud.scaleY = _cloud.scaleX;
			var bounds: Rectangle = _cloud.getBounds( _cloud );
			_cloud.x = -bounds.x * _cloud.scaleX;
			_cloud.y = -bounds.y * _cloud.scaleY;
		}
		
		public function get targetWidth(): Number
		{
			return _targetWidth;
		}
	}
}
