package za.co.skycorp.lightning.view.interfaces
{
	import za.co.skycorp.lightning.model.enum.StringEnum;

	/**
	 * @author Chris Truter
	 */
	public interface IIdentifiable
	{
		function set id(value:StringEnum):void;

		function get id():StringEnum;
	}
}