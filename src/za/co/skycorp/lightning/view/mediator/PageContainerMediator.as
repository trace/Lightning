package za.co.skycorp.lightning.view.mediator
{
	import org.robotlegs.mvcs.SignalMediator;
	import za.co.skycorp.lightning.controller.signals.PageSignal;
	import za.co.skycorp.lightning.model.enum.PageAction;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.proxies.PageProxy;
	import za.co.skycorp.lightning.model.vo.PageVO;
	import za.co.skycorp.lightning.view.containers.PageContainer;
	import za.co.skycorp.lightning.view.interfaces.IPage;


	/**
	 * @author Chris Truter
	 */
	public class PageContainerMediator extends SignalMediator
	{
		[Inject]
		public var view:PageContainer;
		[Inject]
		public var proxy:PageProxy;
		[Inject]
		public var signal:PageSignal;

		override public function onRegister():void
		{
			addToSignal(signal, handleSignal);
		}

		override public function onRemove():void
		{
			super.onRemove();
			proxy = null;
			signal = null;
		}

		private function handleSignal(action:PageAction, vo:PageVO):void
		{
			switch(action)
			{
				case PageAction.CLOSE:
					view.closePage(vo.id);
					break;
				case PageAction.HAS_CLOSED:
					proxy.id = StringEnum.BLANK;
					view.removePage(vo.id);
					break;
				case PageAction.HAS_OPENED:
					proxy.id = vo.id;
					view.activatePage(vo.id);
					break;
				case PageAction.OPEN:
					var page:IPage = proxy.getPage(vo.id);
					view.openPage(page);
					break;
			}
		}
	}
}