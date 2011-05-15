package za.co.skycorp.lightning.model.proxies
{
	import aze.motion.easing.Cubic;
	import aze.motion.easing.Linear;
	import aze.motion.eaze;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import org.robotlegs.mvcs.Actor;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.factories.SoundFactory;
	import za.co.skycorp.lightning.model.proxies.helpers.SoundAssistVO;
	import za.co.skycorp.lightning.model.proxies.helpers.SoundDictionary;




	/**
	 * TODO: unit tests
	 *
	 * Play Sfx and Loops.
	 *
	 * Cross fade loops.
	 *
	 * Adjust volumes of currently playing sounds.
	 *
	 * @author Chris Truter
	 */
	public class SoundProxy extends Actor
	{
		[Inject]
		public var factory:SoundFactory;
		
		private var _isMuted:Boolean = false;
		private var _loop:Sound;
		private var _loopChannel:SoundChannel;
		private var _loopVolume:Number;
		private var _sfxChannels:Vector.<SoundChannel>;
		
		// deprecate
		private var _sfxVolume:Number;
		private var _sounds:SoundDictionary;

		/* StringEnum => { Sound, Vec<Channels> } */
		public function SoundProxy()
		{
			_sfxChannels = new Vector.<SoundChannel>;
			_sounds = new SoundDictionary;

			_loopVolume = .8;
			_sfxVolume = .8;
		}

		public function get loopVolume():Number
		{
			return _loopVolume;
		}

		public function set loopVolume(value:Number):void
		{
			if (!_loopChannel)
				return;

			_loopVolume = value;
			fadeVolume(_loopChannel, value, 2);
		}

		public function get volume():Number
		{
			return _sfxVolume;
		}

		public function set volume(value:Number):void
		{
			value = Math.pow(value, 1.4);

			for (var i:int = 0; i < _sfxChannels.length; i++)
				if (_sfxChannels[i])
					_sfxChannels[i].soundTransform = new SoundTransform(value);

			_sfxVolume = value;
		}

		public function playSound(id:StringEnum, vol:Number = -1):void
		{
			if (_isMuted)
				return;

			var vo:SoundAssistVO = _sounds.getSoundLazy(id, factory);
			var sound:Sound = vo.sound;

			if (sound)
			{
				var sTrans:SoundTransform = new SoundTransform(_sfxVolume);

				if (vol != -1)
					sTrans.volume *= vol;

				var sc:SoundChannel = sound.play(0, 0, sTrans);
				if (!sc)
					return;
				// safety if no sound device

				vo.channels.push(sc)
				_sfxChannels.push(sc);
				sc.addEventListener(Event.SOUND_COMPLETE, handleSoundComplete);
			}
		}

		public function setLoop(id:StringEnum):void
		{
			var newLoop:Sound = _sounds.getSoundLazy(id, factory).sound;

			if (!newLoop || newLoop == _loop)
				return;

			if (_loopChannel)
				_loopChannel.stop();

			_loop = newLoop;
			_loopChannel = _loop.play(0, 0, new SoundTransform(0));
			if (!_loopChannel)
				return;
			// safety if no sound device

			var vol:Number = !_isMuted ? _loopVolume : 0;
			_loopChannel.soundTransform.volume = 0;
			fadeVolume(_loopChannel, vol, 3);

			_loopChannel.addEventListener(Event.SOUND_COMPLETE, handleLoopComplete);
		}

		/**
		 * Called to stop a sound
		 * @param	id
		 */
		public function stopSound(id:StringEnum = null):void
		{
			if (id == null)
			{
				// stop all
				for (var key:String in _sounds.keys)
				{
					// SoundMixer.stopAll();
					if (_sounds.getSound(key))
					{
						channels = _sounds.getSound(key).channels;
						for (i = 0, len = channels.length; i < len; i++)
							channels[i].stop();
					}
				}
			}
			else
			{
				var channels:Vector.<SoundChannel> = _sounds.getSound(id.value).channels;
				for (var i:int = 0, len:uint = channels.length; i < len; i++)
					channels[i].stop();
			}
		}

		public function toggleMute():void
		{
			if (!_isMuted)
				stopSound();
			// SoundMixer.stopAll();
			var ease:Function = _isMuted ? Cubic.easeOut : Linear.easeNone;
			var vol:Number = _isMuted ? _loopVolume : 0;
			fadeVolume(_loopChannel, vol, 2, ease);

			_isMuted = !_isMuted;
		}

		private function handleLoopComplete(e:Event):void
		{
			var vol:Number = !_isMuted ? _loopVolume : 0;
			_loopChannel.removeEventListener(Event.SOUND_COMPLETE, handleLoopComplete);
			_loopChannel = _loop.play(0, 0, new SoundTransform(vol));
			if (!_loopChannel)
				return;
			// safety if no sound device
			_loopChannel.addEventListener(Event.SOUND_COMPLETE, handleLoopComplete);
		}

		private function handleSoundComplete(e:Event):void
		{
			var sc:SoundChannel = e.target as SoundChannel;
			var index:int = _sfxChannels.indexOf(sc);
			_sfxChannels.splice(index, 1);
			for (var key:String in _sounds)
			{
				index = _sounds.getSound(key).channels.indexOf(sc);
				if (index > -1)
					_sounds.getSound(key).channels.splice(index, 1);
			}
			sc.removeEventListener(Event.SOUND_COMPLETE, handleSoundComplete);
		}

		private function fadeVolume(channel:SoundChannel, target:Number, time:Number, easing:Function = null):void
		{
			easing ||= Linear.easeNone;

			var vo:Object = {volume:channel.soundTransform.volume};
			var targetVO:Object = {volume:target};

			eaze(vo)
				.to(time, targetVO)
				.easing(Linear.easeNone)
				.onUpdate(setVolume, channel, vo);
		}

		private function setVolume(sc:SoundChannel, vo:Object):void
		{
			sc.soundTransform = new SoundTransform(vo.volume);
		}
	}
}