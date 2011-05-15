package za.co.skycorp.lightning.controller
{
	import org.robotlegs.mvcs.SignalCommand;
	import za.co.skycorp.lightning.model.enum.SoundAction;
	import za.co.skycorp.lightning.model.proxies.SoundProxy;
	import za.co.skycorp.lightning.model.vo.SoundVO;


	/**
	 * @author Chris Truter
	 */
	public class SoundCommand extends SignalCommand
	{
		[Inject]
		public var action:SoundAction;
		[Inject]
		public var vo:SoundVO;
		[Inject]
		public var proxy:SoundProxy;

		override public function execute():void
		{
			switch(action)
			{
				case SoundAction.LOOP:
					proxy.setLoop(vo.id);
					break;
				case SoundAction.LOOP_VOLUME:
					proxy.loopVolume = vo.volume;
					break;
				case SoundAction.PLAY:
					proxy.playSound(vo.id, vo.volume);
					break;
				case SoundAction.STOP:
					proxy.stopSound(vo.id);
					break;
				case SoundAction.TOGGLE_MUTE:
					proxy.toggleMute();
					break;
				// case SoundAction.VOLUME:
				// proxy.volume = vo.volume;
				// break;
				default:
					throw(new Error("Unsupported SoundAction"));
			}
		}
	}
}