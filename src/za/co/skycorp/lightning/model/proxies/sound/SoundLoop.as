package za.co.skycorp.lightning.model.proxies.sound
{
	import aze.motion.easing.Cubic;
	import aze.motion.easing.Linear;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import za.co.skycorp.lightning.interfaces.IDestroyable;
	/**
	 * ...
	 * @author Chris Truter
	 * date created 27/06/2011
	 */
	public class SoundLoop implements IDestroyable
	{
		public var fadeStrategy:IFadeVolumeStrategy;
		
		private var _loopPlaying:Sound;
		private var _loopChannel:SoundChannel;
		private var _loopVolume:Number;
		private var _isMuted:Boolean;
		
		private function get fadeVolume():Function { return fadeStrategy.execute; }
		
		public function set isMuted(value:Boolean):void
		{
			var ease:Function, vol:Number;
			_isMuted = value;
			if (value)
			{
				ease = Linear.easeNone;
				vol = 0;
			}
			else
			{
				ease = Cubic.easeOut;
				vol = _loopVolume;
			}
			
			fadeVolume(_loopChannel, vol, 2, ease);
		}
		
		public function get volume():Number { return _loopVolume; }
		public function set volume(value:Number):void
		{
			_loopVolume = value;
			if (!_loopChannel) return;
			fadeStrategy.execute(_loopChannel, value, 2);
		}
		
		public function setSound(newLoop:Sound):void
		{
			// ignore if setting to invalid, or current loop.
			if (!newLoop || newLoop == _loopPlaying) return;
			
			if (_loopChannel)
			{
				_loopChannel.removeEventListener(Event.SOUND_COMPLETE, handleLoopComplete);
				_loopChannel.stop();
			}
				
			_loopPlaying = newLoop;
			_loopChannel = _loopPlaying.play(0, 0, new SoundTransform(0));
			
			if (!_loopChannel) return;
			
			var vol:Number = !_isMuted ? _loopVolume : 0;
			_loopChannel.soundTransform.volume = 0;
			
			_loopChannel.addEventListener(Event.SOUND_COMPLETE, handleLoopComplete);
			
			fadeVolume(_loopChannel, vol, 3);
		}
		
		private function handleLoopComplete(e:Event):void
		{
			var vol:Number = !_isMuted ? _loopVolume : 0;
			_loopChannel.removeEventListener(Event.SOUND_COMPLETE, handleLoopComplete);
			_loopChannel = _loopPlaying.play(0, 0, new SoundTransform(vol));
			
			if (!_loopChannel)
				return;

			_loopChannel.addEventListener(Event.SOUND_COMPLETE, handleLoopComplete);
		}
		
		public function destroy():void
		{
			if (_loopChannel)
			{
				_loopChannel.removeEventListener(Event.SOUND_COMPLETE, handleLoopComplete);
				_loopChannel.stop();
			}
			_loopPlaying = null;
			_loopChannel = null;
			
			fadeStrategy = null;
		}
	}
}