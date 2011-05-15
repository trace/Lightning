package za.co.skycorp.lightning.model.enum
{
	/**
	 * @author Chris Truter
	 */
	public class PopupAction extends StringEnum
	{
		static public const OPEN:PopupAction = new PopupAction("open");
		static public const HAS_OPENED:PopupAction = new PopupAction("hasOpened");
		static public const CLOSE:PopupAction = new PopupAction("close");
		static public const HAS_CLOSED:PopupAction = new PopupAction("hasClosed");

		public function PopupAction(value:String)
		{
			super(value);
		}
	}
}