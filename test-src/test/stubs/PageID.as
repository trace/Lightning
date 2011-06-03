package test.stubs {
	import za.co.skycorp.lightning.model.enum.StringEnum;
	/**
	 * @author Chris Truter
	 */
	public class PageID extends StringEnum
	{
		static public const SLOW:PageID = new PageID("slow");
		static public const TEST:PageID = new PageID("testPage");
		static public const INVALID:PageID = new PageID("invalid");
		
		public function PageID(value:String)
		{
			super(value);
		}
	}
}