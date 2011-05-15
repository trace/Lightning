package test.mockups {
	import za.co.skycorp.lightning.model.factories.PageFactory;
	/**
	 * @author Chris Truter
	 */
	public class MockPageFactory extends PageFactory
	{
		public function MockPageFactory()
		{
			registerClass(PageID.TEST, MockPage);
		}
	}
}