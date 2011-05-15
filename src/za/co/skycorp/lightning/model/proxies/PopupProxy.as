package za.co.skycorp.lightning.model.proxies
{
	import flash.utils.Dictionary;
	import org.robotlegs.mvcs.Actor;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.factories.PopupFactory;
	import za.co.skycorp.lightning.view.interfaces.IPopup;



	/**
	 * Simple facade for creating Popups. Caches on id, unless forced to created.
	 *
	 * Also can cache an already created popup.
	 *
	 * @author Chris Truter
	 */
	public class PopupProxy extends Actor
	{
		[Inject]
		public var factory:PopupFactory;
		private var _popups:Dictionary;

		/* StringEnum => IPopup */
		public function PopupProxy()
		{
			_popups = new Dictionary;
		}

		/**
		 * Cache an already-create popup. Useful for pre-created content.
		 * @param	id
		 * @param	instance
		 */
		public function cache(id:StringEnum, instance:IPopup):void
		{
			_popups[id] = instance;
		}

		public function getPopup(id:StringEnum, forceNew:Boolean = false):IPopup
		{
			if (forceNew || !_popups[id])
			{
				_popups[id] = factory.createPopup(id);
				_popups[id].id = id;
			}
			return _popups[id];
		}
	}
}