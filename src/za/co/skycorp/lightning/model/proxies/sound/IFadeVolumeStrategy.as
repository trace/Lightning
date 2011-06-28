package za.co.skycorp.lightning.model.proxies.sound
{
	import flash.media.SoundChannel;
	
	/**
	 * @author Chris Truter
	 */
	public interface IFadeVolumeStrategy
	{
		function execute(channel:SoundChannel, target:Number, time:Number, easing:Function = null):void;
	}
}