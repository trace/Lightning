package test
{
	import asunit.framework.TestSuite;
	import test.models.factories.BasicFactoryTest;
	import test.models.proxies.PageProxyTest;
	import test.models.proxies.PopupProxyTest;
	import test.models.proxies.SoundProxyTest;
	import test.models.services.AMFServiceTest;
	import test.utils.FormValidatorTest;
	import test.utils.SafelyRemoveChildTest;
	import test.view.containers.PageContainerTest;
	import test.view.containers.PopupContainerTest;
	import test.view.containers.SlidingPageContainerTest;
	import test.view.core.ApplicationTest;
	import test.view.elements.buttons.TimelineButtonTest;
	import test.view.mediators.PageMediatorTest;
	import test.view.mediators.PopupMediatorTest;

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
			addTest(new PageMediatorTest);
			addTest(new SlidingPageContainerTest);
			// popups
			addTest(new PopupProxyTest);
			addTest(new PopupMediatorTest);
			addTest(new PopupContainerTest);
			//addTest(new GetRealBoundsTest);
			addTest(new AMFServiceTest);
			// factories
			addTest(new BasicFactoryTest);
			// proxies
			addTest(new SoundProxyTest);
			// utils
			addTest(new FormValidatorTest);
			addTest(new SafelyRemoveChildTest);
			// view
			addTest(new ApplicationTest);
			addTest(new TimelineButtonTest);
		}
	}
}