package za.co.skycorp.lightning.view.interfaces
{
	import za.co.skycorp.lightning.controller.signals.PageSignal;
	import za.co.skycorp.lightning.controller.signals.SoundSignal;
	import za.co.skycorp.lightning.interfaces.IDestroyable;

	/**
	 * @author Chris Truter
	 */
	public interface IPage extends IOpenable, ISprite, IIdentifiable, IDestroyable
	{
		function activate():void;

		function deactivate():void;

		function get pageSignal():PageSignal;

		function set pageSignal(value:PageSignal):void;

		function get sound():SoundSignal;

		function set sound(value:SoundSignal):void;
	}
}