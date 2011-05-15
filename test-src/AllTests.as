package
{
	import asunit.framework.TestSuite;

	import test.plugins.pages.PageContainerTest;
	import test.plugins.pages.PageProxyTest;
	import test.plugins.popups.PopupContainerTest;
	import test.plugins.popups.PopupMediatorTest;
	import test.plugins.popups.PopupProxyTest;
	import test.plugins.services.AMFServiceTest;

	/**
	 * @author Chris Truter
	 */
	public class AllTests extends TestSuite
	{
		public function AllTests()
		{
			super();

			// pages
			addTest(new PageProxyTest);
			addTest(new PageContainerTest);

			// popups
			addTest(new PopupProxyTest);
			addTest(new PopupMediatorTest);
			addTest(new PopupContainerTest);

			// addTest(new GetRealBoundsTest);
			addTest(new AMFServiceTest);
		}
	}
}