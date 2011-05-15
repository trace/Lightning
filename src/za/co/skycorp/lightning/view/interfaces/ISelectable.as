package za.co.skycorp.lightning.view.interfaces
{
	/**
	 * @author Chris Truter
	 */
	public interface ISelectable
	{
		function select():void;

		function deselect():void;

		function get isSelected():Boolean;
	}
}