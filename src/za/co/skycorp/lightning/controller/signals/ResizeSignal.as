package za.co.skycorp.lightning.controller.signals
{
	import flash.geom.Point;
	import org.osflash.signals.Signal;

	/**
	 * Payload is X, Y
	 *
	 * @author Chris Truter
	 */
	public class ResizeSignal extends Signal
	{
		public function ResizeSignal()
		{
			super(Number, Number);
		}
	}
}