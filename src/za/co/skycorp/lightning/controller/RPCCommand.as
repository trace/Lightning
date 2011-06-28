package za.co.skycorp.lightning.controller
{
	import org.robotlegs.mvcs.SignalCommand;
	import za.co.skycorp.lightning.model.enum.RPCAction;
	import za.co.skycorp.lightning.model.services.IRPCService;
	import za.co.skycorp.lightning.model.vo.RPCVO;

	/**
	 * Run an asynchronous RPC.
	 *
	 * @author Chris Truter
	 */
	public class RPCCommand extends SignalCommand
	{
		[Inject] public var action:RPCAction;
		[Inject] public var vo:RPCVO;
		[Inject] public var service:IRPCService;

		override public function execute():void
		{
			service.callMethod(action.value, vo.promise, vo.params);
		}
	}
}