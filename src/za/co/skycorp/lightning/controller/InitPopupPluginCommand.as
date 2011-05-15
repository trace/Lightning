package za.co.skycorp.lightning.controller
{
	import org.robotlegs.mvcs.Command;
	import za.co.skycorp.lightning.controller.signals.PopupSignal;
	import za.co.skycorp.lightning.model.factories.PopupFactory;
	import za.co.skycorp.lightning.model.proxies.PopupProxy;
	import za.co.skycorp.lightning.view.containers.PopupContainer;
	import za.co.skycorp.lightning.view.mediator.PopupContainerMediator;


	/**
	 * @author Chris Truter
	 */
	public class InitPopupPluginCommand extends Command
	{
		override public function execute():void
		{
			mediatorMap.mapView(PopupContainer, PopupContainerMediator);

			injector.mapSingleton(PopupProxy);
			injector.mapSingleton(PopupSignal);
			injector.mapSingleton(PopupFactory);
		}
	}
}