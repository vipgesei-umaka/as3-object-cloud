package at.leichtgewicht.cloud.ui 
{
	import at.leichtgewicht.cloud.PositionEvent;
	import at.leichtgewicht.cloud.ObjectCloud;

	import flash.display.Sprite;

	/**
	 * @author Martin Heidegger
	 * @version 1.0
	 */
	public class ProgressDisplay extends Sprite 
	{
		private var _progressRing: ProgressRing;
		
		public function ProgressDisplay( cloud: ObjectCloud )
		{
			addChild( _progressRing = new ProgressRing() );
			_progressRing.visible = false;

			addChild( cloud );
			cloud.addEventListener( PositionEvent.NEXT_POSITION_FOUND, onNextPosition );
		}

		private function onNextPosition( event: PositionEvent ): void
		{
			if( _progressRing.visible = ( event.percentage != 1 ) )
			{
				_progressRing.percentage = event.percentage;
			}
		}
	}
}
