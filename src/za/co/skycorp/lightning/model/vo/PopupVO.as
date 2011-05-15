package za.co.skycorp.lightning.model.vo
{
	import za.co.skycorp.lightning.model.enum.StringEnum;

	/**
	 * This VO will most likely be used to hack on extra properties in particular projects.
	 *
	 * @author Chris Truter
	 */
	public class PopupVO
	{
		public var id:StringEnum;

		public function PopupVO(id:StringEnum)
		{
			this.id = id;
		}
	}
}