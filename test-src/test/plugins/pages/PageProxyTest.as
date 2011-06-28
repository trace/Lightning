package test.plugins.pages {
	import asunit.framework.TestCase;
	import test.stubs.PageID;
	import test.stubs.PageStub;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.factories.PageFactory;
	import za.co.skycorp.lightning.model.proxies.PageProxy;
	import za.co.skycorp.lightning.view.interfaces.IPage;


	/**
	 * @author Chris Truter
	 */
	public class PageProxyTest extends TestCase
	{
		public var instance:PageProxy;
		
		public function PageProxyTest(method:String = null)
		{
			super(method);
		}
		
		override protected function setUp():void
		{
            super.setUp();
			instance = new PageProxy;
			var factory:PageFactory = new PageFactory;
			factory.registerClass(PageID.TEST, PageStub);
			instance.factory = factory;
        }

        override protected function tearDown():void
		{
			super.tearDown();
			instance.factory = null;
			instance = null;
		}
		
		public function testInstantiated():void
		{
			assertTrue("instance is PageProxy", instance is PageProxy);
			assertTrue("instance has factory", instance.factory is PageFactory);
		}
		
		public function testCreatePage():void
		{
			var page:IPage = instance.getPage(PageID.TEST);
			assertNotNull("instance creates page", page);
			assertEquals("instance creates correct page", page.id, PageID.TEST);
		}
		
		public function testCreateFail():void
		{
			var page:IPage = instance.getPage(PageID.INVALID);
			assertNull("instance does not create invalid pages", page);
		}
		
		public function testCreatePooled():void
		{
			var firstPage:IPage = instance.getPage(PageID.TEST);
			var secondPage:IPage = instance.getPage(PageID.TEST);
			assertEquals("instances caches popups", firstPage, secondPage);
		}
		
		public function testSaveGetID():void
		{
			var a:StringEnum = new StringEnum("a");
			var b:StringEnum = new StringEnum("b");
			instance.id = a;
			assertEquals("instances stores current id.", instance.id, a);
			instance.id = b;
			assertEquals("instances stores current id.", instance.id, b);
			assertEquals("instances stores current previous id.", instance.prevID, a);
			
			instance.id = StringEnum.BLANK;
			assertEquals("instances stores current id.", instance.id, StringEnum.BLANK);
			assertEquals("instances does not clear previous id when cleared.", instance.prevID, a);
		}
		
		public function testCreateUnique():void
		{
			var firstPage:IPage = instance.getPage(PageID.TEST);
			var secondPage:IPage = instance.getPage(PageID.TEST, true);
			assertNotSame("instances creates new page when forced", firstPage, secondPage);
		}
	}
}