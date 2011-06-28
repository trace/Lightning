package za.co.skycorp.lightning.view.mediator
{
	import org.robotlegs.mvcs.SignalMediator;
	import za.co.skycorp.lightning.controller.signals.PageSignal;
	import za.co.skycorp.lightning.controller.signals.SoundSignal;
	import za.co.skycorp.lightning.view.interfaces.IPage;

	/**
	 * @author Chris Truter
	 */
	public class PageMediator extends SignalMediator
	{
		[Inject] public var signal:PageSignal;
		[Inject] public var sound:SoundSignal;
		
		protected function get page():IPage { return viewComponent as IPage; }
		
		override public function onRegister():void
		{
			page.pageSignal = signal;
			page.sound = sound;
		}
		
		override public function onRemove():void
		{
			page.pageSignal = null;
			page.sound = null;
			signal = null;
			sound = null;
		}
	}
}