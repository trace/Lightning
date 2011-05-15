package test.plugins.popups
{
	import asunit.framework.TestCase;
	import test.mockups.MockPopup;
	import test.mockups.PopupID;
	import za.co.skycorp.lightning.controller.signals.PopupSignal;
	import za.co.skycorp.lightning.model.enum.PopupAction;
	import za.co.skycorp.lightning.model.proxies.PopupProxy;
	import za.co.skycorp.lightning.model.vo.PopupVO;
	import za.co.skycorp.lightning.view.containers.PopupContainer;
	import za.co.skycorp.lightning.view.interfaces.IPopup;
	import za.co.skycorp.lightning.view.mediator.PopupContainerMediator;
	import za.co.skycorp.lightning.view.mediator.PopupMediator;
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.adapters.SwiftSuspendersReflector;
	import org.robotlegs.base.MediatorMap;
	import flash.display.Sprite;

	/**
	 * @author Chris Truter
	 */
	public class PopupContainerTest extends TestCase
	{
		private var instance:PopupContainer;
		private var contextView:Sprite;
		private var map:MediatorMap;
		private var mediator:PopupMediator;
		private var mediator2:PopupContainerMediator;
		private var popup:MockPopup;
		private var proxy:PopupProxy;
		private var signal:PopupSignal;
		private var _hasOpened:Boolean;
		private var _hasClosed:Boolean;

		public function PopupContainerTest(method:String = null)
		{
			super(method);
		}

		override protected function setUp():void
		{
			super.setUp();

			instance = new PopupContainer;

			popup = new MockPopup;
			proxy = new PopupProxy;
			mediator = new PopupMediator;
			mediator2 = new PopupContainerMediator;
			contextView = new Sprite;
			map = new MediatorMap(contextView, new SwiftSuspendersInjector, new SwiftSuspendersReflector);
			signal = new PopupSignal;

			signal.add(handleSignal);

			mediator.signal = signal;
			mediator2.signal = signal;
			mediator2.view = instance;
			mediator2.proxy = proxy;
			contextView.addChild(instance);
			proxy.cache(PopupID.TEST, popup);
			// test factory cache
			map.mapView(MockPopup, PopupMediator, IPopup);
			map.mapView(PopupContainer, PopupContainerMediator, IPopup);

			_hasClosed = _hasOpened = false;
		}

		private function handleSignal(action:PopupAction, vo:PopupVO):void
		{
			// kill FDT warning
			vo;
			switch(action)
			{
				case PopupAction.HAS_CLOSED:
					_hasClosed = true;
					break;
				case PopupAction.HAS_OPENED:
					_hasOpened = true;
					break;
			}
		}

		override protected function tearDown():void
		{
			if (mediator.contextView)
				mediator.preRemove();

			mediator.signal = null;
			mediator2.preRemove();
			mediator2.view = null;
			mediator2.proxy = null;
			mediator2.signal = null;
			contextView.removeChild(instance);
			signal.removeAll();

			instance = null;
			contextView = null;
			popup = null;
			proxy = null;
			mediator = null;
			map = null;
			signal = null;

			_hasClosed = _hasOpened = false;

			super.tearDown();
		}

		public function testInstantiated():void
		{
			assertTrue("Instance is PopupContainer", instance is PopupContainer);
		}

		public function testSignals():void
		{
			map.registerMediator(popup, mediator);
			map.registerMediator(instance, mediator2);

			// test open + has_opened
			signal.open(PopupID.TEST);
			assertEquals("There is one popup open", 1, instance.length);
			assertTrue("Signal recognising opening", _hasOpened);

			// test close + has_closed
			signal.close(PopupID.TEST);
			assertEquals("There are no popups open", 0, instance.length);
			assertTrue("Signal recognising closing", _hasClosed);
		}
	}
}