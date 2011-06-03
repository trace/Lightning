package test.plugins.pages {
	import asunit.framework.TestCase;
	import flash.display.Sprite;
	import test.stubs.PageID;
	import test.stubs.PageStub;
	import test.stubs.SlowPageStub;
	import za.co.skycorp.lightning.controller.signals.PageSignal;
	import za.co.skycorp.lightning.view.containers.PageContainer;

	/**
	 * @author Chris Truter
	 */
	public class PageContainerTest extends TestCase
	{
		public var instance:PageContainer;
		public var page:PageStub;
		public var second:SlowPageStub;
		
		public function PageContainerTest(method:String = null)
		{
			super(method);
		}
		
		override protected function setUp():void
		{
            super.setUp();
			
			instance = new PageContainer;
			page = new PageStub;
			second = new SlowPageStub;
			
			page.id = PageID.TEST;
			second.id = PageID.SLOW;
        }

        override protected function tearDown():void
		{
			super.tearDown();
			
			page.destroy();
			page.pageSignal = null;
			page = null;
			instance = null;
			second.deactivate();
			second.pageSignal = null;
			second = null;
		}
		
		public function testInstantiated():void
		{
			assertTrue("instance is PageContainer", instance is PageContainer);
		}
		
		public function testOpenPage():void
		{
			assertNull("no page inside to start", instance.page);
			
			assertTrue("page opens immediately if nothing else around", instance.openPage(page));
			assertEquals("page opens immediately if nothing else around", instance.page, page);
			
			assertFalse("ignores currently open page", instance.openPage(page));
			assertTrue("ignores currently open page", page.visible);
			
			instance.openPage(second);
			assertFalse("closes current page", page.visible);
			
			assertEquals("closes current page only once", 0, second.closeCount);
			
			assertEquals("no queue yet", 0, instance.queueLength);
			instance.openPage(page);
			assertEquals("queues if page open already", 1, instance.queueLength);
			
			assertEquals("closes current page only once", 1, second.closeCount);
			instance.openPage(page);
			assertEquals("closes current page only once", 1, second.closeCount);
		}
		
		public function testClosePage():void
		{
			assertFalse("does nothing if no page open", instance.closePage(PageID.TEST));
			instance.openPage(page);
			assertFalse("does nothing if id does not match", instance.closePage(PageID.INVALID));
			assertTrue("does something if id does match", instance.closePage(PageID.TEST));
			assertFalse("does something if id does match", page.visible);
		}
		
		public function testRemovePage():void
		{
			instance.openPage(page);
			
			var spr:Sprite = new Sprite;
			spr.addChild(page);
			assertEquals("removes child only if still valid", page.parent, spr);
			assertTrue("destroys child only if still valid", page.active);
			// manually close
			page.close();
			
			assertFalse("ensure page not still open", page.visible);
			instance.openPage(second);
			instance.openPage(page);
			second.dispatchClosed();
			assertTrue("if queue, unshift and open next element", page.visible);
		}
	}
}