package za.co.skycorp.lightning.model.factories
{
	import flash.utils.Dictionary;
	import za.co.skycorp.lightning.model.enum.StringEnum;


	/**
	 * @author Chris Truter
	 */
	public class BasicFactory
	{
		protected var _type:Class;
		protected var _dict:Dictionary;

		/* StrinEnum => ::_type:: */
		public function BasicFactory(type:Class)
		{
			_type = type;
			_dict = new Dictionary;
		}

		public function registerClass(id:StringEnum, _Class:Class):void
		{
			// TODO: this should not actually create it..
			// use reflection dummy.
			var temp:* = new _Class;
			if (!(temp is _type))
				throw(new Error("Can only register classes of type: " + _type));

			_dict[id] = _Class;
		}

		public function createInstance(id:StringEnum):*
		{
			if (_dict[id])
				return new _dict[id];
			else
				return null;
		}
	}
}