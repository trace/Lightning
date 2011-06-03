package test.plugins.popups {
	import asunit.framework.TestCase;
	import flash.display.Sprite;
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.adapters.SwiftSuspendersReflector;
	import org.robotlegs.base.MediatorMap;
	import org.robotlegs.mvcs.Mediator;
	import test.stubs.PopupStub;
	import za.co.skycorp.lightning.controller.signals.PopupSignal;
	import za.co.skycorp.lightning.view.interfaces.IPopup;
	import za.co.skycorp.lightning.view.mediator.PopupMediator;

	/**
	 * @author Chris Truter
	 */
	public class PopupMediatorTest extends TestCase
	{
		private var popup:PopupStub;
		private var mediator:PopupMediator;
		private var map:MediatorMap;
		
		public function PopupMediatorTest(method:String = null)
		{
			super(method);
		}
		
		override protected function setUp():void
		{
            super.setUp();
			
			popup = new PopupStub;
			mediator = new PopupMediator;
			map = new MediatorMap(new Sprite, new SwiftSuspendersInjector, new SwiftSuspendersReflector);
			
			mediator.signal = new PopupSignal;
			map.mapView(PopupStub, PopupMediator, IPopup);
        }

        override protected function tearDown():void
		{
			super.tearDown();
			
			if (mediator.contextView)
				mediator.preRemove();
			
			popup = null;
			mediator = null;
			map = null;
		}
		
		public function testInstantiated():void
		{
			assertTrue("Instance is Mediator", mediator is Mediator);
		}
		
		public function testSignalPassed():void
		{
			map.registerMediator(popup, mediator);
			assertTrue("PopupSignal is passed to the popup.", popup.popupSignal is PopupSignal);
		}
	}
}