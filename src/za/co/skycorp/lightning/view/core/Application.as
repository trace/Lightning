package za.co.skycorp.lightning.view.core
{
	import net.hires.debug.Logger;
	import net.hires.debug.Stats;

	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	/**
	 * @author Chris Truter
	 */
	public class Application extends Sprite
	{
		protected var _context:Context;
		protected var _keyDown:NativeSignal;
		protected var _logger:Logger;
		private var _stats:Stats;
		private var _isDebugging:Boolean;

		public function Application()
		{
			if (stage) init();
			else new NativeSignal(this, Event.ADDED_TO_STAGE, Event).addOnce(init);
		}

		protected function init(e:* = null):void
		{
			_keyDown ||= new NativeSignal(stage, KeyboardEvent.KEY_DOWN, KeyboardEvent);

			if (_isDebugging)
				_keyDown.add(handleKey);
		}

		public function set isDebugging(value:Boolean):void
		{
			if (value)
			{
				_stats ||= new Stats;
				_logger ||= new Logger;

				_stats.visible = _logger.visible = false;

				_stats.visible = _logger.visible = false;

				stage.addChild(_stats);
				stage.addChild(_logger);

				if (_keyDown)
					_keyDown.add(handleKey);
			}
			else
			{
				safelyRemove(_stats);
				safelyRemove(_logger);

				if (_keyDown)
					_keyDown.remove(handleKey);
			}
		}

		private function handleKey(e:KeyboardEvent):void
		{
			if (e.keyCode == 83) // S
				_stats.visible = !_stats.visible;
			if (e.keyCode == 76) // L
				_logger.visible = !_logger.visible;
		}

		private function safelyRemove(child:DisplayObject):void
		{
			if (child)
				if (child.parent)
					child.parent.removeChild(child);
		}
	}
}