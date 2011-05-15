package za.co.skycorp.lightning.model.services
{
	import net.hires.debug.Logger;

	import org.robotlegs.mvcs.Actor;
	import org.robotlegs.oil.async.Promise;

	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;

	/**
	 * Wrapper for AMF RPCs.
	 *
	 * @author Chris Truter
	 */
	public class AMFService extends Actor implements IRPCService
	{
		private var _connection:NetConnection;
		private var _gateway:String;
		private var _service:String;
		private var _promise:Promise;

		public function set service(value:String):void
		{
			if (_connection) disconnect();
			Logger.debug("Service assigned: " + value);
			_service = value;
		}

		public function set gateway(value:String):void
		{
			if (_connection) disconnect();
			Logger.debug("Gateway assigned: " + value);
			_gateway = value;
		}

		private function disconnect():void
		{
			_connection.removeEventListener(NetStatusEvent.NET_STATUS, _promise.handleError);
			_connection = null;
		}

		public function callMethod(method:String, promise:Promise, params:Array):void
		{
			Logger.debug("AMF Call: " + method);
			promise.addErrorHandler(handleError);
			if (!_connection)
				throw(new Error("Service and Gateway must be set"));
			method = _service + "." + method;
			var responder:Responder = new Responder(promise.handleResult, promise.handleError);
			_connection.call.apply(_connection, [method, responder].concat(params));
		}

		public function connect():Promise
		{
			if (!_service || !_gateway)
				throw(new Error("Service and Gateway must be set"));

			var p:Promise = new Promise;

			p.addErrorHandler(handleNetStatus);
			_connection = new NetConnection;
			_connection.addEventListener(NetStatusEvent.NET_STATUS, p.handleError);
			_connection.connect(_gateway);

			_promise = p;

			return p;
		}

		private function handleError(promise:Promise):void
		{
			Logger.debug(this + " ->handleError: " + promise.error.faultString);
		}

		private function handleNetStatus(p:Promise):void
		{
			var e:NetStatusEvent = p.error;
			Logger.debug("NetStatus:", e);
			for (var s:String in e.info)
				Logger.debug(" > " + s + ": " + e.info[s]);
		}
	}
}