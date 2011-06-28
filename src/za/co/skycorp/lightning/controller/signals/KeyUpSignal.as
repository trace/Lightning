package za.co.skycorp.lightning.controller.signals
{
	import org.osflash.signals.Signal;

	/**
	 * Payload is the keycode.
	 *
	 * @author Chris Truter
	 */
	public class KeyUpSignal extends Signal
	{
		public function KeyUpSignal()
		{
			super(int);
		}
	}
}