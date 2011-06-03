package test.plugins.popups {
	import asunit.framework.TestCase;
	import test.stubs.PopupFactoryStub;
	import test.stubs.PopupID;
	import za.co.skycorp.lightning.model.factories.PopupFactory;
	import za.co.skycorp.lightning.model.proxies.PopupProxy;
	import za.co.skycorp.lightning.view.interfaces.IPopup;


	/**
	 * @author Chris Truter
	 */
	public class PopupProxyTest extends TestCase
	{
		public var instance:PopupProxy;
		
		public function PopupProxyTest(method:String = null)
		{
			super(method);
		}
		
		override protected function setUp():void
		{
            super.setUp();
			instance = new PopupProxy;
			instance.factory = new PopupFactoryStub;
        }

        override protected function tearDown():void
		{
			super.tearDown();
			instance.factory = null;
			instance = null;
		}
		
		public function testInstantiated():void
		{
			assertTrue("instance is PopupProxy", instance is PopupProxy);
			assertTrue("instance has factory", instance.factory is PopupFactory);
		}
		
		public function testCreatePopup():void
		{
			var popup:IPopup = instance.getPopup(PopupID.TEST);
			assertNotNull("instance creates popup", popup);
			assertEquals("instance creates correct popup", popup.id, PopupID.TEST);
		}
		
		public function testCreateFail():void
		{
			try
			{
				var popup:IPopup = instance.getPopup(PopupID.INVALID);
			}
			catch (e:Error)
			{
				assertNull("instance does not create invalid popups", popup);
			}
		}
		
		public function testCreatePooled():void
		{
			var firstPopup:IPopup = instance.getPopup(PopupID.TEST);
			var secondPopup:IPopup = instance.getPopup(PopupID.TEST);
			assertEquals("instances caches popups", firstPopup, secondPopup);
		}
		
		public function testCreateUnique():void
		{
			var firstPopup:IPopup = instance.getPopup(PopupID.TEST);
			var secondPopup:IPopup = instance.getPopup(PopupID.TEST, true);
			assertNotSame("instances creates new popup when forced", firstPopup, secondPopup);
		}
	}
}