package test.stubs
{
	import za.co.skycorp.lightning.view.interfaces.IPage;

	/**
	 * Takes 50ms to close. Used for tests involving queues. Also to ensure not spamming close.
	 *
	 * @author Chris Truter
	 */
	public class SlowPageStub extends PageStub implements IPage
	{
		override public function close():void
		{
			_closeCount++;
		}
	}
}