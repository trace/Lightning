package za.co.skycorp.lightning.view.core
{
	import flash.display.Sprite;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
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
		private var _onOpened:Signal = new Signal;
		private var _onClosed:Signal  = new Signal;
		private var _pageSignal:PageSignal;
		private var _sound:SoundSignal;

		public function AbstractPage()
		{
			deactivate();
		}
		
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
		
		public function get onOpened():ISignal { return _onOpened; };
		
		public function get onClosed():ISignal { return _onClosed; }; // accesssor to exist in Interface..

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
			_onOpened = null;
			_onClosed = null;
			if (parent)
				parent.removeChild(this);
			while (numChildren > 0)
				removeChildAt(numChildren - 1);
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
			_onOpened.dispatch();
		}

		protected function handleClosed():void
		{
			_onClosed.dispatch();
		}
	}
}