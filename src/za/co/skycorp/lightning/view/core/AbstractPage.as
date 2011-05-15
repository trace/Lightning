package za.co.skycorp.lightning.view.core
{
	import flash.display.Sprite;
	import za.co.skycorp.lightning.controller.signals.PageSignal;
	import za.co.skycorp.lightning.controller.signals.SoundSignal;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.view.interfaces.IPage;


	/**
	 * @author Chris Truter
	 */
	public class AbstractPage extends Sprite implements IPage
	{
		private var _id:StringEnum;
		private var _pageSignal:PageSignal;
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

		public function get pageSignal():PageSignal
		{
			return _pageSignal;
		}

		public function set pageSignal(value:PageSignal):void
		{
			_pageSignal = value;
		}

		public function get sound():SoundSignal
		{
			return _sound;
		}

		public function set sound(value:SoundSignal):void
		{
			_sound = value;
		}

		/** ACTIVATE / DEACTIVATE **/
		public function activate():void
		{
			mouseEnabled = mouseChildren = true;
		}

		public function deactivate():void
		{
			;
		}

		/** DESTROY **/
		public function destroy():void
		{
			deactivate();
			if (parent)
				parent.removeChild(this);
		}

		/** OPEN / CLOSE **/
		public function open():void
		{
			visible = true;
			handleOpened();
		}

		public function close():void
		{
			visible = false;
			handleClosed();
		}

		/** Utility **/
		protected function handleOpened():void
		{
			if (_pageSignal) _pageSignal.hasOpened(id);
		}

		protected function handleClosed():void
		{
			if (_pageSignal) _pageSignal.hasClosed(id);
		}
	}
}