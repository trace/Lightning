package za.co.skycorp.lightning.controller
{
	import org.robotlegs.mvcs.SignalCommand;
	import za.co.skycorp.lightning.controller.signals.PageSignal;
	import za.co.skycorp.lightning.model.factories.PageFactory;
	import za.co.skycorp.lightning.model.proxies.PageProxy;
	import za.co.skycorp.lightning.view.containers.PageContainer;
	import za.co.skycorp.lightning.view.mediator.PageContainerMediator;

	/**
	 * @author Chris Truter
	 */
	public class InitPagePluginCommand extends SignalCommand
	{
		override public function execute():void
		{
			mediatorMap.mapView(PageContainer, PageContainerMediator);

			injector.mapSingleton(PageProxy);
			injector.mapSingleton(PageSignal);
			injector.mapSingleton(PageFactory);
		}
	}
}