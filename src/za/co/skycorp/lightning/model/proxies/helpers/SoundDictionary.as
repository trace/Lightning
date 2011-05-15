package za.co.skycorp.lightning.model.proxies.helpers
{
	import flash.media.Sound;
	import flash.utils.Dictionary;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.factories.SoundFactory;


	/**
	 * @author palentine
	 */
	public class SoundDictionary
	{
		public var _data:Dictionary = new Dictionary;

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

		public function getSoundLazy(key:StringEnum, factory:SoundFactory):SoundAssistVO
		{
			if (_data[key.value])
				return getSound(key.value);

			var sound:Sound = factory.createSound(key);
			var vo:SoundAssistVO = new SoundAssistVO(sound);
			setSound(key.value, vo);

			return vo;
		}
	}
}
