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
		
		private var _pending:Vector.<Promise> = new Vector.<Promise>;
		
		public function set service(value:String):void
		{
			if (_service == value) return;
			if (_connection) disconnect();
			_service = value;
			Logger.debug("Service assigned: " + value);
		}

		public function set gateway(value:String):void
		{
			if (_gateway == value) return;
			if (_connection) disconnect();
			_gateway = value;
			Logger.debug("Gateway assigned: " + value);
		}

		private function disconnect():void
		{
			//_connection.removeEventListener(NetStatusEvent.NET_STATUS, _promise.handleError);
			_connection.close();
			//_connection = null;
		}

		public function callMethod(method:String, promise:Promise, params:Array):void
		{
			if (!_connection)
			{
				Logger.debug("Auto-connecting on method call: " + method);
				connect();
			}
				
			method = _service + "." + method;
			
			if (promise)
			{
				_pending.push(promise);
			}
			
			var responder:Responder = new Responder(handleCallMethodResult, handleCallMethodError);
			_connection.call.apply(_connection, [method, responder].concat(params));
			
			function handleCallMethodResult(result:Object):void
			{
				Logger.debug("AMF Call Success");
				if (promise)
				{
					promise.handleResult(result);
					removePending(promise);
				}
			}
			
			function handleCallMethodError(error:Object):void
			{
				Logger.debug("AMF Call Failure");
				if (promise)
				{
					promise.handleError(Error);
					removePending(promise);
				}
			}
			
			Logger.debug("AMF Call: " + method);
		}
		
		private function removePending(promise:Promise):void
		{
			var id:int = _pending.indexOf(promise);
			if (id > -1)
				_pending.splice(id, 1);
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

		private function handleNetStatus(p:Promise):void
		{
			var e:NetStatusEvent = p.error;
			Logger.debug("NetStatus:", e);
			for (var s:String in e.info)
				Logger.debug(" > " + s + ": " + e.info[s]);
				
			for (var i:int = _pending.length -1; i >= 0;  i--)
			{
				_pending[i].handleError(p.error);
				removePending(_pending[i]);
			}
			
			disconnect();
		}
	}
}