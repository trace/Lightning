package za.co.skycorp.lightning.view.core
{
	import aze.motion.eaze;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import net.hires.debug.Logger;
	import net.hires.debug.Stats;
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Context;
	import za.co.skycorp.lightning.interfaces.IDestroyable;
	import za.co.skycorp.lightning.utils.safelyRemoveChild;

	/**
	 * @author Chris Truter
	 */
	public class Application extends Sprite implements IDestroyable
	{
		protected var _context:Context;
		protected var _keyDown:NativeSignal;
		protected var _logger:Sprite;
		protected var _stats:Sprite;
		
		private var _isDebugging:Boolean;
		private var _isRevealing:Boolean;
		private var _revealedItem:DisplayObject;
		
		public function Application()
		{
			if (stage) init();
			else new NativeSignal(this, Event.ADDED_TO_STAGE, Event).addOnce(init);
		}
		
		public function destroy():void
		{
			_keyDown.removeAll();
			safelyRemoveChild(this);
			while (numChildren > 0) removeChildAt(numChildren - 1);
			removeEventListener(MouseEvent.CLICK, handleClickReveal);
		}
		
		protected function init(e:* = null):void
		{
			_keyDown ||= new NativeSignal(stage, KeyboardEvent.KEY_DOWN, KeyboardEvent);
			
			if (_isDebugging) _keyDown.add(handleKey);
		}
		
		public function set isDebugging(value:Boolean):void
		{
			if (value)
			{
				_stats ||= new Stats;
				_logger ||= new Logger;
				
				_stats.visible = _logger.visible = false;
				
				if (stage)
				{
					stage.addChild(_stats);
					stage.addChild(_logger);
				}
				
				if (_keyDown) _keyDown.add(handleKey);
			}
			else
			{
				safelyRemoveChild(_stats);
				safelyRemoveChild(_logger);
				
				if (_isRevealing) toggleReveal();
				if (_keyDown) _keyDown.remove(handleKey);
			}
		}
		
		protected function handleKey(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case 76: // L
					_logger.visible = !_logger.visible;
					break;
				case 82: // R
					toggleReveal();
					break;
				case 83: // S
					_stats.visible = !_stats.visible; // TODO this still leaves overhead
					break;
			}
		}
		
		private function toggleReveal():void
		{
			_isRevealing = !_isRevealing;
			if (_isRevealing)
			{
				addEventListener(MouseEvent.CLICK, handleClickReveal);
			}
			else
			{
				if (_revealedItem)
					revealItem(_revealedItem)
				removeEventListener(MouseEvent.CLICK, handleClickReveal);
			}
		}
		
		private function handleClickReveal(e:MouseEvent):void
		{
			revealItem(e.target as DisplayObject);
		}
		
		private function revealItem(target:DisplayObject):void
		{
			if (_revealedItem)
			{
				var toggled:Boolean = _revealedItem == target;
				eaze(_revealedItem).colorMatrix();
				_revealedItem = null;
				if (toggled) return;
			}
			
			Logger.debug("Clicked on: ");
			Logger.debug("> object: " + target);
			Logger.debug("> name: " + target.name);
			Logger.debug("> parent: " + target.parent);
			eaze(target).colorMatrix(0, 0, 0, 0, 0xff0000, .8);
			
			_revealedItem = target;
		}
	}
}