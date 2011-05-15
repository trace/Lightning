package za.co.skycorp.lightning.model.vo
{
	import za.co.skycorp.lightning.model.enum.SoundID;

	/**
	 * @author Chris Truter
	 */
	public class SoundVO
	{
		static public const NULL:SoundVO = new SoundVO;
		public var id:SoundID;
		public var volume:Number;
		// unused
		public var pan:Number;
		public var offset:Number;

		public function SoundVO(id:SoundID = null, volume:Number = 1)
		{
			this.id = id;
			this.volume = volume;
		}
	}
}