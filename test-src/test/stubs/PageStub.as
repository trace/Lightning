package test.stubs
{
	import za.co.skycorp.lightning.view.core.AbstractPage;
	import za.co.skycorp.lightning.view.interfaces.IPage;
	/**
	 * @author Chris Truter
	 */
	public class PageStub extends AbstractPage implements IPage
	{
		public var active:Boolean;
		
		protected var _closeCount:int = 0;
		
		public function get closeCount():int
		{
			return _closeCount;
		}
		
		override public function close():void
		{
			_closeCount++;
			super.close();
		}
		
		public function dispatchClosed():void
		{
			handleClosed();
		}
		
		override public function activate():void
		{
			active = true;
			super.activate();
		}
		
		override public function deactivate():void
		{
			active = false;
			super.deactivate();
		}
	}
}