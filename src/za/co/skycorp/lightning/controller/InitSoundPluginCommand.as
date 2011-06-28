package za.co.skycorp.lightning.controller
{
	import org.robotlegs.mvcs.SignalCommand;
	import za.co.skycorp.lightning.controller.signals.SoundSignal;
	import za.co.skycorp.lightning.model.factories.SoundFactory;
	import za.co.skycorp.lightning.model.proxies.SoundProxy;

	/**
	 * @author Chris Truter
	 */
	public class InitSoundPluginCommand extends SignalCommand
	{
		override public function execute():void
		{
			signalCommandMap.mapSignalClass(SoundSignal, SoundCommand);

			injector.mapSingleton(SoundFactory);
			injector.mapSingleton(SoundProxy);
		}
	}
}