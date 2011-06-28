package za.co.skycorp.lightning.utils
{
	import flash.display.DisplayObject;

	/**
	 * @author Chris Truter
	 */
	public function safelyRemoveChild(child:DisplayObject):Boolean
	{
		if (child && child.parent)
			return child.parent.removeChild(child) != null;
		return false;
	}
}