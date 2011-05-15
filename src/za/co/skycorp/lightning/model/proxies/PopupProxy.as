package za.co.skycorp.lightning.model.proxies
{
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.factories.PopupFactory;
	import za.co.skycorp.lightning.view.interfaces.IPopup;
	import org.robotlegs.mvcs.Actor;
	import flash.utils.Dictionary;

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
		/* StringEnum => IPopup */
		private var _popups:Dictionary;
		
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
				var popup:IPopup = factory.createPopup(id);
				popup.id = id;
				_popups[id] = popup;
			}
			return _popups[id];
		}
	}
}