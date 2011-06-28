package za.co.skycorp.lightning.model.proxies.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import za.co.skycorp.lightning.interfaces.IDestroyable;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.factories.SoundFactory;

	/**
	 * TODO - rapid play protection.
	 *
	 * @author palentine
	 */
	public class SoundList implements IDestroyable
	{
		public var factory:SoundFactory;
		
		private var _data:Dictionary = new Dictionary;

		/* String => SoundAssistVO */
		public function get keys():Array
		{
			var arr:Array = [];
			for (var k:String in _data) arr.push(k);
			return arr;
		}

		public function getSound(key:String):SoundAssistVO
		{
			return SoundAssistVO(_data[key]);
		}

		public function setSound(key:String, value:SoundAssistVO):void
		{
			_data[key] = value;
		}

		/**
		 * Get sound if exists, otherwise create it
		 * @param	key
		 * @return	The wrapped sound.
		 */
		public function getSoundLazy(key:StringEnum):SoundAssistVO
		{
			if (_data[key.value])
				return getSound(key.value);
			
			var sound:Sound = factory.createSound(key);
			var vo:SoundAssistVO = new SoundAssistVO(sound);
			setSound(key.value, vo);
			
			return vo;
		}
		
		
		public function stopChannelsOf(id:String):void
		{
			if (id == null)
			{
				// SoundMixer.stopAll();
				for (var key:String in keys)
					stopChannelsOf(key);
				return;
			}
			
			var vo:SoundAssistVO = getSound(id);
			if (vo)
			{
				var channels:Vector.<SoundChannel> = vo.channels;
				for (var i:int = 0, len:int = channels.length; i < len; i++)
					channels[i].stop();
			}
		}
		
		public function setChannelsVolume(value:Number):void
		{
			for (var key:String in keys)
			{
				var vo:SoundAssistVO = getSound(key);
				if (vo)
				{
					var channels:Vector.<SoundChannel> = vo.channels;
					for (var i:int = 0, len:int = channels.length; i < len; i++)
						channels[i].soundTransform = new SoundTransform(value);;
				}
			}
		}
		
		public function playSound(id:StringEnum, normalizedVol:Number):SoundChannel
		{
			var vo:SoundAssistVO = getSoundLazy(id);
			if (vo.sound)
			{
				var sTrans:SoundTransform = new SoundTransform(normalizedVol);
				var sc:SoundChannel = vo.sound.play(0, 0, sTrans);
				if (!sc)
				{
					return null;
				}
				else
				{
					vo.addChannel(sc);
					return sc;
				}
			}
			return null;
		}
		
		public function destroy():void
		{
			factory = null;
			_data = null;
		}
	}
}
