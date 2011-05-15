package test.plugins.pages {
	import asunit.framework.TestCase;
	import flash.display.Sprite;
	import test.mockups.MockPage;
	import test.mockups.MockSlowPage;
	import test.mockups.PageID;
	import za.co.skycorp.lightning.controller.signals.PageSignal;
	import za.co.skycorp.lightning.view.containers.PageContainer;



	/**
	 * @author Chris Truter
	 */
	public class PageContainerTest extends TestCase
	{
		public var instance:PageContainer;
		public var page:MockPage;
		public var second:MockSlowPage;
		public var signal:PageSignal;
		public var mediator:MockMediator;
		
		public function PageContainerTest(method:String = null)
		{
			super(method);
		}
		
		override protected function setUp():void
		{
            super.setUp();
			
			instance = new PageContainer;
			page = new MockPage;
			second = new MockSlowPage;
			signal = new PageSignal;
			mediator = new MockMediator;
			
			page.id = PageID.TEST;
			page.pageSignal = signal;
			second.id = PageID.SLOW;
			second.pageSignal = signal;
			mediator.container = instance;
			signal.add(mediator.handleSignal);
        }

        override protected function tearDown():void
		{
			super.tearDown();
			
			signal.removeAll();
			signal = null;
			page.pageSignal = null;
			page = null;
			instance = null;
			mediator.container = null;
			mediator = null;
			second.deactivate();
			second.pageSignal = null;
			second = null;
		}
		
		public function testInstantiated():void
		{
			assertTrue("instance is PageContainer", instance is PageContainer);
		}
		
		public function testActivatePage():void
		{
			assertFalse("cannot activate non-page", instance.activatePage(PageID.INVALID));
			assertFalse("cannot activate non-page", instance.activatePage(PageID.TEST));
			
			instance.openPage(page);
			assertTrue("can activate open page", instance.activatePage(PageID.TEST));
			assertTrue("can activate open page", page.active);
			
			instance.openPage(second);
			instance.openPage(page);
			instance.activatePage(PageID.SLOW);
			assertFalse("immediately close if queue", second.active);
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
			assertFalse("does nothing if no page", instance.removePage(PageID.TEST));
			instance.openPage(page);
			assertFalse("does nothing if id does not match", instance.removePage(PageID.INVALID));
			
			assertTrue("removes child if still valid", instance.removePage(PageID.TEST));
			assertFalse("destroys child if still valid", page.active);
			
			instance.openPage(page);
			instance.activatePage(PageID.TEST);
			
			var spr:Sprite = new Sprite;
			spr.addChild(page);
			assertEquals("removes child only if still valid", page.parent, spr);
			assertTrue("destroys child only if still valid", page.active);
			// manually close
			page.close();
			
			assertFalse("ensure page not still open", page.visible);
			instance.openPage(second);
			instance.openPage(page);
			instance.removePage(PageID.SLOW);
			assertTrue("if queue, unshift and open next element", page.visible);
		}
	}
}
import za.co.skycorp.lightning.model.enum.PageAction;
import za.co.skycorp.lightning.model.vo.PageVO;
import za.co.skycorp.lightning.view.containers.PageContainer;

class MockMediator
{
	public var container:PageContainer;
	
	public function handleSignal(action:PageAction, vo:PageVO):void
	{
		switch(action)
		{
			case PageAction.HAS_CLOSED:
				container.removePage(vo.id);
				break;
			case PageAction.HAS_OPENED:
				container.activatePage(vo.id);
				break;
		}
	}
}