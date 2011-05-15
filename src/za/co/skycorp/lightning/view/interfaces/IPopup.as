package za.co.skycorp.lightning.view.interfaces
{
	import za.co.skycorp.lightning.controller.signals.PopupSignal;
	import za.co.skycorp.lightning.controller.signals.SoundSignal;

	/**
	 * @author Chris Truter
	 */
	public interface IPopup extends IOpenable, IIdentifiable, ISprite
	{
		function get popupSignal():PopupSignal;

		function set popupSignal(value:PopupSignal):void;

		function get sound():SoundSignal;

		function set sound(value:SoundSignal):void;
	}
}