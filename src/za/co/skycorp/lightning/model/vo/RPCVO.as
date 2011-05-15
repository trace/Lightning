package za.co.skycorp.lightning.model.vo
{
	import org.robotlegs.oil.async.Promise;

	/**
	 * @author Chris Truter
	 */
	public class RPCVO
	{
		public var promise:Promise;
		public var params:Array;

		public function RPCVO(promise:Promise, params:Array)
		{
			this.promise = promise;
			this.params = params;
		}
	}
}