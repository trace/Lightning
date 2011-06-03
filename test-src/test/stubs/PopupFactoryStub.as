package test.stubs {
	import za.co.skycorp.lightning.model.factories.PopupFactory;
	/**
	 * @author Chris Truter
	 */
	public class PopupFactoryStub extends PopupFactory
	{
		public function PopupFactoryStub()
		{
			registerClass(PopupID.TEST, PopupStub);
		}
	}
}