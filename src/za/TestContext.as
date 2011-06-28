package za
{
	import flash.display.DisplayObjectContainer;
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.SignalContext;
	import test.stubs.ColouredPage;
	import za.co.skycorp.lightning.controller.InitPagePluginCommand;
	import za.co.skycorp.lightning.controller.signals.PageSignal;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.factories.PageFactory;
	import za.co.skycorp.lightning.view.containers.PageContainer;
	import za.co.skycorp.lightning.view.containers.SlidingPageContainer;
	import za.co.skycorp.lightning.view.mediator.PageContainerMediator;
	/**
	 * @author Chris Truter
	 */
	public class TestContext extends SignalContext
	{
		public function TestContext(contextView:DisplayObjectContainer)
		{
			super(contextView);
		}
		
		override public function startup():void
		{
			var s:Signal = new Signal;
			signalCommandMap.mapSignal(s, InitPagePluginCommand, true);
			
			s.dispatch();
			
			mediatorMap.mapView(SlidingPageContainer, PageContainerMediator, PageContainer);
			
			var proxy:PageFactory = injector.getInstance(PageFactory);
			proxy.registerClass(Main.id1, ColouredPage);
			proxy.registerClass(Main.id2, ColouredPage);
			proxy.registerClass(Main.id3, ColouredPage);
			proxy.registerClass(Main.id4, ColouredPage);
			proxy.registerClass(Main.id5, ColouredPage);
		}
		
		public function openPage(id:StringEnum):void { injector.getInstance(PageSignal).open(id); }
		
		public function addContainerPages(container:SlidingPageContainer):void
		{
			for each (var id:StringEnum in container.ids)
				openPage(id);
		}
	}
}