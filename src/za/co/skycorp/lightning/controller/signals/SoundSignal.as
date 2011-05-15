package za.co.skycorp.lightning.controller.signals
{
	import org.osflash.signals.Signal;
	import za.co.skycorp.lightning.model.enum.SoundAction;
	import za.co.skycorp.lightning.model.vo.SoundVO;


	/**
	 * @author Chris Truter
	 */
	public class SoundSignal extends Signal
	{
		public function SoundSignal()
		{
			super(SoundAction, SoundVO);
		}
	}
}