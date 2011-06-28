package test.models.services {
	import asunit.framework.TestCase;
	import za.co.skycorp.lightning.model.services.AMFService;

	/**
	 * @author Chris Truter
	 */
	public class AMFServiceTest extends TestCase
	{
		public var instance:AMFService;
		
		public function AMFServiceTest(method:String = null)
		{
			super(method);
		}
		
		override protected function setUp():void
		{
            super.setUp();
			instance = new AMFService;
        }

        override protected function tearDown():void
		{
			super.tearDown();
			instance = null;
		}
		
		public function testConnect():void
		{
			
		}
	}
}