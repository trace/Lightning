package test.stubs {
	import za.co.skycorp.lightning.model.enum.StringEnum;
	/**
	 * @author Chris Truter
	 */
	public class PopupID extends StringEnum
	{
		static public const TEST:PopupID = new PopupID("testPopup");
		static public const INVALID:PopupID = new PopupID("invalid");
		
		public function PopupID(value:String)
		{
			super(value);
		}
	}
}