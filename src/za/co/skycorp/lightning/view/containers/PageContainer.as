package za.co.skycorp.lightning.view.containers
{
	import flash.display.Sprite;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.view.interfaces.IPage;


	/**
	 * @author Chris Truter
	 */
	public class PageContainer extends Sprite
	{
		private var _page:IPage;
		private var _queue:Vector.<IPage>;
		private var _isClosing:Boolean;

		public function PageContainer()
		{
			_queue = new Vector.<IPage>;
		}

		/**
		 * Currently opening, open, or closing page.
		 */
		public function get page():IPage
		{
			return _page;
		}

		public function get queueLength():int
		{
			return _queue.length;
		}

		/**
		 * Activates the current page.
		 * Immediately closes and cueues opening next page, if queue exists.
		 * @param	id
		 * @return	false if nothing performed, true otherwise
		 */
		public function activatePage(id:StringEnum):Boolean
		{
			if (!_page || id != _page.id)
				return false;

			if (_queue.length > 0)
				removePage(id);
			else
				_page.activate();

			return true;
		}

		/**
		 * Open page, unless another is open. If another is open, close it, and add this page to the queue to open.
		 * If this is the currently open page, ignore.
		 * @param	page
		 * @return	false if nothing performed, true otherwise
		 */
		public function openPage(newPage:IPage):Boolean
		{
			if (_page)
				if (newPage.id == _page.id)
					return false;

			if (_page)
			{
				_queue.push(newPage);
				closePage(_page.id);
				return true;
			}
			else
			{
				_page = newPage;
				addChild(newPage.display);
				newPage.open();
				return true;
			}
		}

		/**
		 * If page is open, and matches id, close it.
		 * @param	page
		 * @return	false if nothing performed, true otherwise
		 */
		public function closePage(id:StringEnum):Boolean
		{
			if (_page && _page.id == id)
			{
				if (!_isClosing)
				{
					_isClosing = true;
					_page.close();
				}
				return true;
			}
			return false;
		}

		/**
		 * Remove page from display list and deactive, if currently active and a child of the container.
		 * If queue, open next element.
		 * @param	id
		 * @return  false if nothing performed, true otherwise
		 */
		public function removePage(id:StringEnum):Boolean
		{
			if (!_page || _page.id != id)
				return false;

			_isClosing = false;

			if ((_page.display.parent == this))
			{
				removeChild(_page.display);
				_page.destroy();
			}
			_page = null;

			if (_queue.length > 0)
				openPage(_queue.shift());

			return true;
		}
	}
}