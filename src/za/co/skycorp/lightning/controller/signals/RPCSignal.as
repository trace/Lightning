package za.co.skycorp.lightning.controller.signals
{
	import org.osflash.signals.Signal;
	import org.robotlegs.oil.async.Promise;
	import za.co.skycorp.lightning.model.enum.RPCAction;
	import za.co.skycorp.lightning.model.vo.RPCVO;


	/**
	 * @author Chris Truter
	 */
	public class RPCSignal extends Signal
	{
		public function RPCSignal()
		{
			super(RPCAction, RPCVO);
		}

		public function call(method:String, promise:Promise, params:Array = null):void
		{
			params ||= [];
			dispatch(new RPCAction(method), new RPCVO(promise, params));
		}
	}
}