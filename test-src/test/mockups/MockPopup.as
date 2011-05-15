package test.mockups {
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.view.core.AbstractPopup;
	import za.co.skycorp.lightning.view.interfaces.IPopup;
	/**
	 * @author Chris Truter
	 */
	public class MockPopup extends AbstractPopup implements IPopup
	{
		override public function get id():StringEnum { return PopupID.TEST; }
	}
}