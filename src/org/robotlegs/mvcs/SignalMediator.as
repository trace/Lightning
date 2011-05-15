/**
 * modified from:
 *     https://github.com/Stray/robotlegs-demo-StrategyGame/blob/master/src/org/robotlegs/mvcs/SignalMediator.as
 */
package org.robotlegs.mvcs
{
	import flash.utils.Dictionary;

	import org.osflash.signals.ISignal;
	// import org.robotlegs.core.IRelaxedEventMap;
	import org.robotlegs.mvcs.Mediator;

	public class SignalMediator extends Mediator
	{
		// [Inject]
		// public var relaxedEventMap:IRelaxedEventMap;
		protected var _handlersBySignal:Dictionary;

		public function SignalMediator()
		{
			super();
		}

		override public function preRemove():void
		{
			removeAllSignalHandlers();
			// relaxedEventMap.unmapListenersFor(this);
			super.preRemove();
		}

		/**
		 * Signal cleanup helper
		 * 
		 */
		protected function addToSignal(signal:ISignal, handler:Function):void
		{
			signal.add(handler);
			if (handlersBySignal[signal] == null)
			{
				handlersBySignal[signal] = [];
			}
			handlersBySignal[signal].push(handler);
		}

		protected function get handlersBySignal():Dictionary
		{
			return _handlersBySignal || (_handlersBySignal = new Dictionary());
		}

		protected function removeAllSignalHandlers():void
		{
			for ( var signal:Object in handlersBySignal)
			{
				var handlers:Array = handlersBySignal[signal];
				for each (var handler:Function in handlers)
				{
					(signal as ISignal).remove(handler);
				}
			}

			_handlersBySignal = null;
		}
	}
}