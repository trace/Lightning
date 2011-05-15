package za.co.skycorp.lightning.model.factories
{
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.view.interfaces.IPopup;

	/**
	 * @author Chris Truter
	 */
	public class PopupFactory extends BasicFactory
	{
		public function PopupFactory()
		{
			super(IPopup);
		}

		public function createPopup(id:StringEnum):IPopup
		{
			return createInstance(id) as IPopup;
		}
	}
}