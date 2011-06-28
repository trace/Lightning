package test.stubs.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * @author Chris Truter
	 * date created 27/06/2011
	 */
	public class InvalidSound extends Sound
	{
		override public function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel
		{
			return null;
		}
	}
}