package za.co.skycorp.lightning.model.enum
{
	/**
	 * Useful with Signal + Robotlegs
	 *
	 * @author Chris Truter
	 */
	public class StringEnum
	{
		static public const BLANK:StringEnum = new StringEnum("");
		private var _value:String;

		public function StringEnum(value:String)
		{
			_value = value;
		}

		public function get value():String { return _value; }
		public function set value(value:String):void { _value = value; }

		public function toString():String { return _value; }
	}
}