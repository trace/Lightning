package za.co.skycorp.lightning.model.proxies.sound
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	/**
	 * Container for a sound, and all its currently playing channels.
	 *
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
		
		public function addChannel(sc:SoundChannel):void
		{
			channels.push(sc);
			sc.addEventListener(Event.SOUND_COMPLETE, handleSoundComplete);
		}
		
		private function handleSoundComplete(e:Event):void
		{
			var sc:SoundChannel = e.target as SoundChannel;
			var index:int = channels.indexOf(sc);
			if (index > -1)
				channels.splice(index, 1);
			sc.removeEventListener(Event.SOUND_COMPLETE, handleSoundComplete);
		}
	}
}
