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
		private var _targetWidth: Number;
		private var _targetHeight: Number;
		
		public function SizeFitter( cloud: ObjectCloud, width: Number = 250, height: Number = 300 )
		{
			_targetWidth = width;
			_targetHeight = height;
			addChild( _cloud = cloud );
			_cloud.addEventListener( RenderProgressEvent.UPDATE, onPositionFound );
		}
		
		private function onPositionFound(event: RenderProgressEvent): void
		{
			if( width / height > _targetWidth / _targetHeight )
			{
				_cloud.width = _targetWidth;
				_cloud.scaleY = _cloud.scaleX;
			}
			else
			{
				_cloud.height = _targetHeight;
				_cloud.scaleX = _cloud.scaleY;
			}
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
