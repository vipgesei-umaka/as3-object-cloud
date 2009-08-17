package at.leichtgewicht.cloud.ui 
{
	import at.leichtgewicht.cloud.tool.SizeFitter;
	import at.leichtgewicht.cloud.RenderProgressEvent;
	import at.leichtgewicht.cloud.ObjectCloud;

	import flash.display.Sprite;

	/**
	 * @author Martin Heidegger
	 * @version 1.0
	 */
	public class ProgressDisplay extends Sprite 
	{
		private var _progressRing: ProgressRing;
		private var _sizeFitter: SizeFitter;

		public function ProgressDisplay( cloud: ObjectCloud )
		{
			addChild( _progressRing = new ProgressRing() );
			_progressRing.visible = false;
			cloud.addEventListener( RenderProgressEvent.UPDATE, onNextPosition );
			addChild( _sizeFitter = new SizeFitter( cloud ) );
		}

		private function onNextPosition( event: RenderProgressEvent ): void
		{
			if( _progressRing.visible = ( event.percentage != 1 ) )
			{
				_progressRing.percentage = event.percentage;
			}
		}
	}
}
