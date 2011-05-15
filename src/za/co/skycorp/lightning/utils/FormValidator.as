package za.co.skycorp.lightning.utils
{
	/**
	 * @author Chris Truter
	 */
	public class FormValidator
	{
		/**
		 *
		 * @param	str
		 * @return
		 */
		public static function validateNonempty(str:String):Boolean
		{
			return str && str.length > 0;
		}

		public static function validatePostalCode(str:String):Boolean
		{
			return str && str.match(/^\d{5}$/);
		}

		public static function validateEmail(str:String):Boolean
		{
			return str && str.match(/[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/i) != null;
		}

		static public function stripWhitespace(str:String):String
		{
			return str.replace(/^\s+|\s+$/g, "");
		}
	}
}