package test.view.containers
{
	import asunit.framework.TestCase;
	import test.stubs.PageID;
	import test.stubs.PageStub;
	import za.co.skycorp.lightning.view.containers.SlidingPageContainer;
	/**
	 * TODO: unit tests
	 *
	 * @author Chris Truter
	 */
	public class SlidingPageContainerTest extends TestCase
	{
		private var instance:SlidingPageContainer;
		private var page:PageStub;
		
		public function SlidingPageContainerTest(method:String = null)
		{
			super(method);
		}
		
		override protected function setUp():void
		{
            super.setUp();
			
			instance = new SlidingPageContainer;
			page = new PageStub;
        }

        override protected function tearDown():void
		{
			super.tearDown();
			
			page = null;
			instance = null;

		}
		
		public function testInstantiated():void
		{
			assertTrue("instance is SlidingPageContainer", instance is SlidingPageContainer);
		}
		
		// test all pages are visible
		
		// test opened page is 0,0
		
		// test origional position is conserved
		
		// test pages all deactivated
		
		// test page deactivates
		
		// test page activates
	}
}