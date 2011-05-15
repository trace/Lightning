package za.co.skycorp.lightning.controller.signals
{
	import org.osflash.signals.Signal;
	import za.co.skycorp.lightning.model.enum.PopupAction;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.vo.PopupVO;


	/**
	 * @author Chris Truter
	 */
	public class PopupSignal extends Signal
	{
		public function PopupSignal()
		{
			super(PopupAction, PopupVO);
		}

		public function open(id:StringEnum):void
		{
			dispatch(PopupAction.OPEN, new PopupVO(id));
		}

		public function close(id:StringEnum):void
		{
			dispatch(PopupAction.CLOSE, new PopupVO(id));
		}

		public function hasClosed(id:StringEnum):void
		{
			dispatch(PopupAction.HAS_CLOSED, new PopupVO(id));
		}

		public function hasOpened(id:StringEnum):void
		{
			dispatch(PopupAction.HAS_OPENED, new PopupVO(id));
		}
	}
}