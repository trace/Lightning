package
{
	import flash.display.Sprite;
	import za.co.skycorp.lightning.view.core.Application;

	public class Main extends Application
	{
		public function Main()
		{
			var s:Sprite = new Sprite;
			s.graphics.beginFill(0xff0000);
			s.graphics.drawRect(5, 5, 100, 200);
			s.graphics.endFill();

			addChild(s);
		}
	}
}
