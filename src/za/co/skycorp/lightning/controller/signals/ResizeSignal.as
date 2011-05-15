package za.co.skycorp.lightning.controller.signals
{
	import org.osflash.signals.Signal;

	/**
	 * @author Chris Truter
	 */
	public class ResizeSignal extends Signal
	{
		public function ResizeSignal()
		{
			super(Number, Number);
			// x, y
		}
	}
}