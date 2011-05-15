package za.co.skycorp.lightning.view.core
{
	import flash.display.Sprite;
	import za.co.skycorp.lightning.controller.signals.PopupSignal;
	import za.co.skycorp.lightning.controller.signals.SoundSignal;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.view.interfaces.IPopup;


	/**
	 * @author Chris Truter
	 */
	public class AbstractPopup extends Sprite implements IPopup
	{
		private var _id:StringEnum;
		private var _popupSignal:PopupSignal;
		private var _sound:SoundSignal;

		public function get display():Sprite
		{
			return this;
		}

		public function get id():StringEnum
		{
			return _id;
		}

		public function set id(value:StringEnum):void
		{
			_id = value;
		}

		public function get popupSignal():PopupSignal
		{
			return _popupSignal;
		}

		public function set popupSignal(value:PopupSignal):void
		{
			_popupSignal = value;
		}

		public function get sound():SoundSignal
		{
			return _sound;
		}

		public function set sound(value:SoundSignal):void
		{
			_sound = value;
		}

		public function close():void
		{
			visible = false;
			handleClosed();
		}

		public function open():void
		{
			visible = true;
			handleOpened();
		}

		protected function handleClosed():void
		{
			_popupSignal.hasClosed(id);
		}

		protected function handleOpened():void
		{
			_popupSignal.hasOpened(id);
		}
	}
}