package test.view.mediators {
	import asunit.framework.TestCase;
	import flash.display.Sprite;
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.adapters.SwiftSuspendersReflector;
	import org.robotlegs.base.MediatorMap;
	import org.robotlegs.mvcs.Mediator;
	import test.stubs.PageStub;
	import za.co.skycorp.lightning.controller.signals.PageSignal;
	import za.co.skycorp.lightning.view.interfaces.IPage;
	import za.co.skycorp.lightning.view.mediator.PageMediator;

	/**
	 * @author Chris Truter
	 */
	public class PageMediatorTest extends TestCase
	{
		private var page:PageStub;
		private var mediator:PageMediator;
		private var map:MediatorMap;
		
		public function PageMediatorTest(method:String = null)
		{
			super(method);
		}
		
		override protected function setUp():void
		{
            super.setUp();
			
			page = new PageStub;
			mediator = new PageMediator;
			map = new MediatorMap(new Sprite, new SwiftSuspendersInjector, new SwiftSuspendersReflector);
			
			mediator.signal = new PageSignal;
			map.mapView(PageStub, PageMediator, IPage);
        }

        override protected function tearDown():void
		{
			super.tearDown();
			
			if (mediator.contextView)
				mediator.preRemove();
			
			page = null;
			mediator = null;
			map = null;
		}
		
		public function testInstantiated():void
		{
			assertTrue("Instance is Mediator", mediator is Mediator);
		}
		
		public function testSignalPassed():void
		{
			map.registerMediator(page, mediator);
			assertTrue("PageSignal is passed to the page.", page.pageSignal is PageSignal);
		}
	}
}