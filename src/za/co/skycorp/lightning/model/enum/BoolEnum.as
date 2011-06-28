package za.co.skycorp.lightning.model.enum
{
	/**
	 * @author Chris Truter
	 */
	public class BoolEnum
	{
		private var _value:Boolean;

		public function BoolEnum(value:Boolean)
		{
			_value = value;
		}

		public function get value():Boolean { return _value; }
		public function set value(value:Boolean):void { _value = value; }

		public function toBoolean():Boolean { return _value; }
	}
}