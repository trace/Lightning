package za.co.skycorp.lightning.controller.signals
{
	import org.osflash.signals.Signal;
	import za.co.skycorp.lightning.model.enum.PageAction;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.vo.PageVO;


	/**
	 * @author Chris Truter
	 */
	public class PageSignal extends Signal
	{
		public function PageSignal()
		{
			super(PageAction, PageVO);
		}

		public function close(id:StringEnum):void
		{
			dispatch(PageAction.CLOSE, new PageVO(id));
		}

		public function open(id:StringEnum):void
		{
			dispatch(PageAction.OPEN, new PageVO(id));
		}
	}
}