package za.co.skycorp.lightning.model.factories
{
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.view.interfaces.IPage;

	/**
	 * @author Chris Truter
	 */
	public class PageFactory extends BasicFactory
	{
		public function PageFactory()
		{
			super(IPage);
		}

		public function createPage(id:StringEnum):IPage
		{
			return createInstance(id) as IPage;
		}
	}
}