package
{
	import asunit.framework.TestCase;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.factories.PageFactory;
	import za.co.skycorp.lightning.model.proxies.PageProxy;
	import za.co.skycorp.lightning.view.containers.SlidingPageContainer;
	import za.co.skycorp.lightning.view.core.Application;
	import za.TestContext;

	public class Main extends Sprite
	{
		static public const id1:StringEnum = new StringEnum("1");
		static public const id2:StringEnum = new StringEnum("2");
		static public const id3:StringEnum = new StringEnum("3");
		static public const id4:StringEnum = new StringEnum("4");
		static public const id5:StringEnum = new StringEnum("5");
		
		private var _context:TestContext;
		private var _queue:Vector.<StringEnum>;
		
		public function Main()
		{
			_context = new TestContext(this);
			
			_queue = Vector.<StringEnum>([
				id1, id2, id3,
				id1, id4, id2,
				id5, id2
			]);
			
			var container:SlidingPageContainer = new SlidingPageContainer;
			
			container.registerPagePosition(id1, new Point(0, 0));
			container.registerPagePosition(id2, new Point(0, 200));
			container.registerPagePosition(id3, new Point(0, 400));
			container.registerPagePosition(id4, new Point(200, 200));
			container.registerPagePosition(id5, new Point(200, 800));
						
			container.x = stage.stageWidth * .5;
			container.y = stage.stageHeight * .5;
			
			addChild(container);
			
			_context.addContainerPages(container);
			
			openNextPage();
		}
		
		private function openNextPage():void
		{
			if (_queue.length > 0)
			{
				var id:StringEnum = _queue.shift();
				_context.openPage(id);
				if (_queue.length > 0)
					setTimeout(openNextPage, 1000);
			}
		}
	}
}