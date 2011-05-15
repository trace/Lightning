package za.co.skycorp.lightning.view.mediator
{
	import org.robotlegs.mvcs.SignalMediator;
	import za.co.skycorp.lightning.controller.signals.PopupSignal;
	import za.co.skycorp.lightning.model.enum.PopupAction;
	import za.co.skycorp.lightning.model.proxies.PopupProxy;
	import za.co.skycorp.lightning.model.vo.PopupVO;
	import za.co.skycorp.lightning.view.containers.PopupContainer;
	import za.co.skycorp.lightning.view.interfaces.IPopup;


	/**
	 * @author Chris Truter
	 */
	public class PopupContainerMediator extends SignalMediator
	{
		[Inject]
		public var view:PopupContainer;
		[Inject]
		public var proxy:PopupProxy;
		[Inject]
		public var signal:PopupSignal;

		override public function onRegister():void
		{
			addToSignal(signal, handleSignal);
			if (view.stage)
				view.resize(view.stage.stageWidth, view.stage.stageHeight);
		}

		override public function onRemove():void
		{
			super.onRemove();
			signal = null;
			view = null;
			proxy = null;
		}

		private function handleSignal(action:PopupAction, vo:PopupVO):void
		{
			switch (action)
			{
				case PopupAction.CLOSE:
					view.closePopup(vo.id);
					break;
				case PopupAction.HAS_CLOSED:
					view.removePopup(vo.id);
					break;
				case PopupAction.HAS_OPENED:
					break;
				case PopupAction.OPEN:
					var popup:IPopup = proxy.getPopup(vo.id);
					view.openPopup(popup);
					break;
				default:
			}
		}
	}
}