package za.co.skycorp.lightning.model.vo
{
	import za.co.skycorp.lightning.model.enum.StringEnum;

	/**
	 * TODO:
	 *
	 * - container id (although, this could be achieved just by wiring up alternate signals)
	 *
	 * - positioning?
	 * - data?
	 *
	 * This VO will most likely be used to hack on extra properties in particular projects.
	 *
	 * @author Chris Truter
	 */
	public class PageVO
	{
		public var id:StringEnum;

		public function PageVO(id:StringEnum)
		{
			this.id = id;
		}
	}
}