package za.co.skycorp.lightning.utils
{
	import flash.net.LocalConnection;

	/**
	 * @author Chris Truter
	 */
	public class FBExternalInterface
	{
		private static var connection:LocalConnection = new LocalConnection();
		public static var connectionName:String;

		public static function callFBJS(methodName:String, parameters:Array):void
		{
			if (connectionName)
				connection.send(connectionName, "callFBJS", methodName, parameters);
		}
	}
}