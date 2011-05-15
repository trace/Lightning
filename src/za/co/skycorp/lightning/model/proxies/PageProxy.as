package za.co.skycorp.lightning.model.proxies
{
	import flash.utils.Dictionary;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.factories.PageFactory;
	import za.co.skycorp.lightning.view.interfaces.IPage;


	/**
	 * Simple facade for creating Pages.
	 *
	 * Caches on id, unless forced to created.
	 *
	 * Also stores the current and previous page IDs.
	 *
	 * @author Chris Truter
	 */
	public class PageProxy
	{
		[Inject]
		public var factory:PageFactory;
		private var _id:StringEnum;
		private var _prevID:StringEnum;
		private var _pages:Dictionary;

		/* StringEnum => IPage */
		public function PageProxy()
		{
			_pages = new Dictionary;
			_id = StringEnum.BLANK;
			_prevID = StringEnum.BLANK;
		}

		public function get id():StringEnum
		{
			return _id;
		}

		public function set id(value:StringEnum):void
		{
			if (value != StringEnum.BLANK && value != null)
				_prevID = _id;
			_id = value;
		}

		public function get prevID():StringEnum
		{
			return _prevID;
		}

		/**
		 * Create new Page by id, or return existing instance, unless forced to created.
		 * @param	id
		 * @param	forceNew
		 * @return	freshly created or existing page, or null if id does not match valid class.
		 */
		public function getPage(id:StringEnum, forceNew:Boolean = false):IPage
		{
			if (forceNew || !_pages[id.value])
			{
				var page:IPage = factory.createPage(id);
				if (!page)
					return null;
				_pages[id.value] = page;
				_pages[id.value].id = id;
			}
			return _pages[id.value];
		}
	}
}