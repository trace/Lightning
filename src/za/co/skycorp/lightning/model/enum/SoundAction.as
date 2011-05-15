package za.co.skycorp.lightning.model.enum
{
	/**
	 * @author Chris Truter
	 */
	public class SoundAction extends StringEnum
	{
		static public const LOOP:SoundAction = new SoundAction("setLoop");
		static public const LOOP_VOLUME:SoundAction = new SoundAction("loopVolume");
		static public const PLAY:SoundAction = new SoundAction("playSample");
		static public const STOP:SoundAction = new SoundAction("stopSound");
		static public const TOGGLE_MUTE:SoundAction = new SoundAction("toggleMute");

		// static public const VOLUME:SoundAction = new SoundAction(SoundEvent.SET_VOLUME);
		public function SoundAction(value:String)
		{
			super(value);
		}
	}
}