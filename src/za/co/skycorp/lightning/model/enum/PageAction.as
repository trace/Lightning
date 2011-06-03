package za.co.skycorp.lightning.model.enum
{
	/**
	 * @author Chris Truter
	 */
	public class PageAction extends StringEnum
	{
		static public const OPEN:PageAction = new PageAction("open");
		static public const CLOSE:PageAction = new PageAction("close");

		public function PageAction(value:String)
		{
			super(value);
		}
	}
}