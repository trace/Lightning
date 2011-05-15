package test.mockups {
	import za.co.skycorp.lightning.model.factories.PopupFactory;
	/**
	 * @author Chris Truter
	 */
	public class MockPopupFactory extends PopupFactory
	{
		public function MockPopupFactory()
		{
			registerClass(PopupID.TEST, MockPopup);
		}
	}
}