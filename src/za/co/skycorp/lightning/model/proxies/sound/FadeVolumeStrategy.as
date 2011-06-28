package za.co.skycorp.lightning.model.proxies.sound
{
	import aze.motion.easing.Linear;
	import aze.motion.eaze;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * Basic fading strategy
	 *
	 * @author Chris Truter
	 * date created 27/06/2011
	 */
	public class FadeVolumeStrategy implements IFadeVolumeStrategy
	{
		public function execute(channel:SoundChannel, target:Number, time:Number, easing:Function = null):void
		{
			if (!channel) return;
			
			easing ||= Linear.easeNone;
			
			var vo:Object = createVO(channel.soundTransform.volume);
			var targetVO:Object = createVO(target);
			
			eaze(vo)
				.to(time, targetVO)
				.easing(Linear.easeNone)
				.onUpdate(fadeVolumeHelper, channel, vo);
		}
		private function fadeVolumeHelper(sc:SoundChannel, vo:Object):void
		{
			sc.soundTransform = new SoundTransform(vo.volume);
		}
		
		private function createVO(value:Number):Object
		{
			return { volume: value };
		}
	}
}