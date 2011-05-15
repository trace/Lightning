package za.co.skycorp.lightning.controller.signals
{
	import org.osflash.signals.Signal;

	/**
	 * @author Chris Truter
	 */
	public class KeyDownSignal extends Signal
	{
		public function KeyDownSignal()
		{
			super(int);
		}
	}
}