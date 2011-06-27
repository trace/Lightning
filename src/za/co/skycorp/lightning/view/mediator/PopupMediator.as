package za.co.skycorp.lightning.view.mediator
{
	import org.robotlegs.mvcs.SignalMediator;
	import za.co.skycorp.lightning.controller.signals.PopupSignal;
	import za.co.skycorp.lightning.controller.signals.SoundSignal;
	import za.co.skycorp.lightning.view.interfaces.IPopup;

	/**
	 * @author Chris Truter
	 */
	public class PopupMediator extends SignalMediator
	{
		[Inject] public var signal:PopupSignal;
		[Inject] public var sound:SoundSignal;
		
		protected function get popup():IPopup { return viewComponent as IPopup; }
		
		override public function onRegister():void
		{
			popup.popupSignal = signal;
			popup.sound = sound;
		}
		
		override public function onRemove():void
		{
			popup.popupSignal =
			popup.sound =
			signal =
			sound = null;
		}
	}
}