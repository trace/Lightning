package za.co.skycorp.lightning.model.enum
{
	/**
	 * @author Chris Truter
	 */
	public class SoundID extends StringEnum
	{
		// Music
		static public var LOOP:SoundID = new SoundID("loop");
		// Interface
		static public const BUTTON_CLICK:SoundID = new SoundID("click");
		static public const BUTTON_ROLL_OVER:SoundID = new SoundID("rollover");

		public function SoundID(value:String)
		{
			super(value);
		}
	}
}