package za.co.skycorp.lightning.view.interfaces
{
	import flash.events.IEventDispatcher;

	/**
	 * @author Chris Truter
	 */
	public interface IResizableContainer extends IResizable, IEventDispatcher, ISprite
	{
		function get sizedHeight():Number;

		function get sizedWidth():Number;
	}
}