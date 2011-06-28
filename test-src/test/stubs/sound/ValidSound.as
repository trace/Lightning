package test.stubs.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * @author Chris Truter
	 * date created 28/06/2011
	 */
	public class ValidSound extends Sound
	{
		
		override public function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel
		{
			var sc:SoundChannel = new SoundChannel;
			sc.soundTransform = sndTransform || new SoundTransform;
			return sc;
		}
	}
}