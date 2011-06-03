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