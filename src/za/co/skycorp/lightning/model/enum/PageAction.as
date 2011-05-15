package za.co.skycorp.lightning.model.enum
{
	/**
	 * @author Chris Truter
	 */
	public class PageAction extends StringEnum
	{
		static public const OPEN:PageAction = new PageAction("open");
		static public const HAS_OPENED:PageAction = new PageAction("hasOpened");
		static public const CLOSE:PageAction = new PageAction("close");
		static public const HAS_CLOSED:PageAction = new PageAction("hasClosed");

		public function PageAction(value:String)
		{
			super(value);
		}
	}
}