package za.co.skycorp.lightning.model.factories
{
	import flash.media.Sound;
	import za.co.skycorp.lightning.model.enum.StringEnum;


	/**
	 * @author Chris Truter
	 */
	public class SoundFactory extends BasicFactory
	{
		public function SoundFactory()
		{
			super(Sound);
		}

		public function createSound(id:StringEnum):Sound
		{
			return createInstance(id) as Sound;
		}
	}
}