package za.co.skycorp.lightning.model.services
{
	import org.robotlegs.oil.async.Promise;

	/**
	 * Interfrace for Remote Procedure Call based APIs
	 * @author Chris Truter
	 */
	public interface IRPCService
	{
		function callMethod(method:String, promise:Promise, params:Array):void;

		function connect():Promise;
	}
}