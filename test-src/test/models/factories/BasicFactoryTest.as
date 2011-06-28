package test.models.factories
{
	import asunit.framework.TestCase;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.factories.BasicFactory;
	/**
	 * @author Chris Truter
	 * date created 28/06/2011
	 */
	public class BasicFactoryTest extends TestCase
	{
		private const ID:StringEnum = new StringEnum("id");
		
		public var factory:BasicFactory;
		
		public function BasicFactoryTest(method:String = null)
		{
			super(method);
		}
		
		override protected function setUp():void
		{
            super.setUp();
			factory = new BasicFactory(BasicItemClass);
        }
		
        override protected function tearDown():void
		{
			super.tearDown();
			factory.destroy();
			factory = null;
		}
		
		public function test_instantiated():void
		{
			assertTrue("Basic Factory can be created", factory is BasicFactory);
		}
		
		public function test_do_nothing_without_registration():void
		{
			assertNull("nothing is created", factory.createInstance(ID));
		}
		
		public function test_creates_registered_object():void
		{
			factory.registerClass(ID, BasicItemClass);
			assertTrue("object exists and is correct type", factory.createInstance(ID) is BasicItemClass);
		}
		
		public function test_creates_unique_objects():void
		{
			factory.registerClass(ID, BasicItemClass);
			var vo1:BasicItemClass = factory.createInstance(ID);
			var vo2:BasicItemClass = factory.createInstance(ID);
			assertNotSame("created instances are unique", vo1, vo2);
		}
		
		public function test_destroy():void
		{
			factory.registerClass(ID, BasicItemClass);
			factory.destroy();
			assertNull("nothing is created", factory.createInstance(ID));
		}
	}
}

class BasicItemClass {}