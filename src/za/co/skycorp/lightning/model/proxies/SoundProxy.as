package za.co.skycorp.lightning.model.proxies
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import za.co.skycorp.lightning.interfaces.IDestroyable;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.factories.SoundFactory;
	import za.co.skycorp.lightning.model.proxies.helpers.SoundDictionary;
	import za.co.skycorp.lightning.model.proxies.sound.FadeVolumeStrategy;
	import za.co.skycorp.lightning.model.proxies.sound.IFadeVolumeStrategy;
	import za.co.skycorp.lightning.model.proxies.sound.SoundLoop;

	/**
	 * Play Sfx and Loops.
	 * Cross fade loops.
	 * Adjust volumes of currently playing sounds.
	 *
	 * TODO: deprecate direct channel communication
	 * TODO: proper destructor
	 *
	 * @author Chris Truter
	 */
	public class SoundProxy implements IDestroyable
	{
		private const DEFAULT_SFX_VOLUME:Number = .8;
		private const DEFAULT_LOOP_VOLUME:Number = .8;
		
		// state
		private var _isMuted:Boolean = false;
		// dependencies
		private var _factory:SoundFactory;
		private var _fadeStrategy:IFadeVolumeStrategy;
		// data
		private var _loop:SoundLoop;
		private var _sfxList:SoundDictionary;
		private var _sfxVolume:Number;
		
		public function SoundProxy()
		{
			_loop = new SoundLoop;
			_loop.volume = DEFAULT_SFX_VOLUME;
			_sfxVolume = DEFAULT_LOOP_VOLUME;
			
			_sfxList = new SoundDictionary;
			_fadeStrategy = new FadeVolumeStrategy;
			_loop.fadeStrategy = _fadeStrategy;
		}
		
		public function get factory():SoundFactory { return _factory; } [Inject]
		public function set factory(value:SoundFactory):void
		{
			_factory = value;
			_sfxList.factory = value;
		}
		
		public function get loopVolume():Number { return _loop.volume; }
		public function set loopVolume(value:Number):void
		{
			_loop.volume = value;
		}
		
		public function get sfxVolume():Number { return _sfxVolume; }
		public function set sfxVolume(value:Number):void
		{
			// transform volume for smoother results
			_sfxVolume = value;
			_sfxList.setChannelsVolume(value);
		}
		
		public function set volume(value:Number):void
		{
			// ratio..
			loopVolume = value;
			sfxVolume = Math.pow(value, 1.4);
		}
		
		private function get fadeVolume():Function { return _fadeStrategy.execute; }
		
		public function destroy():void
		{
			if (_factory) _factory.destroy();
			if (_loop) _loop.destroy();
			if (_sfxList) _sfxList.destroy();
			
			_loop = null;
			_sfxList = null;
			_factory = null;
			_fadeStrategy = null;
		}
		
		/**
		 * @param	id		identifier for sound to play
		 * @param	vol 	if not == -1, sound ratio to regular volume.
		 */
		public function playSound(id:StringEnum, vol:Number = -1):SoundChannel
		{
			if (_isMuted) return null;
			var normalizedVol:Number = vol == -1 ? _sfxVolume : _sfxVolume * vol;
			return _sfxList.playSound(id, normalizedVol);
		}
		
		public function setLoop(id:StringEnum):void
		{
			var newLoop:Sound = _sfxList.getSoundLazy(id).sound;
			_loop.setSound(newLoop);
		}
		
		/**
		 * Called to stop a sound
		 * @param	id
		 */
		public function stopSound(id:StringEnum = null):void
		{
			_sfxList.stopChannelsOf(id ? id.value : null);
		}
		
		public function toggleMute():void
		{
			trace("toggle1", _isMuted);
			trace("toggle2", _isMuted);
			// SoundMixer.stopAll();
			_isMuted = !_isMuted;
			_loop.isMuted = _isMuted;
			trace("toggle3", _isMuted);
			
			if (_isMuted)
				stopSound();
		}
	}
}