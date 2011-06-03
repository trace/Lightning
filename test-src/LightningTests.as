package
{
	import asunit.textui.TestRunner;

	import flash.display.Sprite;
	/**
	 * Run framework tests
	 * @author Chris Truter
	 */
	public class LightningTests extends Sprite
	{
		public function LightningTests():void
		{
			//var s:Sprite = new Sprite;
			//s.graphics.beginFill(0xff0000);
			//s.graphics.drawRect(5, 5, 100, 200);
			//s.graphics.endFill();

			//addChild(s);
			
			var unittests:TestRunner = new TestRunner;
			stage.addChild(unittests);
			unittests.start(AllTests, null, TestRunner.SHOW_TRACE);
		}
	}
}