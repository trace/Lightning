package za.co.skycorp.lightning.model.proxies.helpers
{
	import flash.media.Sound;
	import flash.media.SoundChannel;

	/**
	 * @author palentine
	 */
	public class SoundAssistVO
	{
		public var sound:Sound;
		public var channels:Vector.<SoundChannel> = new Vector.<SoundChannel>;

		public function SoundAssistVO(sound:Sound):void
		{
			this.sound = sound;
		}
	}
}
