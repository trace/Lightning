package test.mockups {
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import za.co.skycorp.lightning.view.interfaces.IPage;

	/**
	 * Takes 50ms to close. Used for tests involving queues. Also to ensure not spamming close.
	 *
	 * @author Chris Truter
	 */
	public class MockSlowPage extends MockPage implements IPage
	{
		private var _id:uint;
		private var _closeCount:int = 0;
		
		public function get closeCount():int
		{
			return _closeCount;
		}
		
		override public function close():void
		{
			_closeCount++;
			if (_id) clearTimeout(_id);
			_id = setTimeout(super.close, 50);
		}
		
		override public function deactivate():void
		{
			if (_id) clearTimeout(_id);
			super.deactivate();
		}
	}
}