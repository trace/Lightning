package
{
	import flash.display.Shape;
	import za.co.skycorp.lightning.view.core.AbstractPage;
	/**
	 * @author Chris Truter
	 */
	public class ColouredPage extends AbstractPage
	{
		private var _asset:Shape;
		
		public function ColouredPage()
		{
			var color:uint = 0xffffff / Math.random();
			_asset = new Shape;
			_asset.graphics.beginFill(color);
			_asset.graphics.drawRect(0, 0, 200, 200);
			_asset.graphics.endFill();
			
			_asset.x = -.5 * _asset.width;
			_asset.y = -.5 * _asset.height;
			
			addChild(_asset);
		}
		
		override public function open():void
		{
			handleOpened();
		}
		
		override public function close():void
		{
			handleClosed();
		}
		
		override public function activate():void
		{
			super.activate();
			alpha = 1;
		}
		
		override public function deactivate():void
		{
			super.deactivate();
			alpha = .5;
		}
	}
}