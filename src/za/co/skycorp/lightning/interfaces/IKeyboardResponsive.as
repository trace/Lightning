package za.co.skycorp.lightning.interfaces
{
	/**
	 * @author Chris Truter
	 */
	public interface IKeyboardResponsive
	{
		function handleKeyUp(keyCode:int):void;

		function handleKeyDown(keyCode:int):void;
	}
}