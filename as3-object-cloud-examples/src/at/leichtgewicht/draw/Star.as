package at.leichtgewicht.draw 
{
	import flash.display.Graphics;

	
	/**
	 * @author Martin Heidegger
	 */
	public class Star 
	{
		public static function drawStar( graphics: Graphics, innerRadius: Number, outerRadius: Number, amountCorners: int, angleOffset: Number = 0 ): void
		{
			var angleStep: Number = Math.PI / amountCorners;
			var angle: Number = angleOffset;
			with( graphics )
			{
				for( var i: int = 0; i<amountCorners; ++i, angle += angleStep )
				{
					if( i == 0 )
					{
						moveTo(
							Math.cos( angle ) * innerRadius,
							Math.sin( angle ) * innerRadius
						);
					}
					else
					{
						lineTo(
							Math.cos( angle ) * innerRadius,
							Math.sin( angle ) * innerRadius
						);
					}
					angle += angleStep;
					lineTo(
						Math.cos( angle ) * outerRadius,
						Math.sin( angle ) * outerRadius
					);
				}
			}
		}
	}
}
