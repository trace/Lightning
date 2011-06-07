package za.co.skycorp.lightning.view.containers
{
	import aze.motion.easing.Cubic;
	import aze.motion.eaze;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.view.interfaces.IPage;
	/**
	 * @author Chris Truter
	 * date created 03/06/2011
	 */
	public class SlidingPageContainer extends PageContainer
	{
		private var _initialized:Boolean;
		private var _keys:Vector.<StringEnum>;
		private var _positions:Dictionary; // StringEnum => Point
		private var _x:Number;
		private var _y:Number;
		
		public function SlidingPageContainer()
		{
			_keys = new Vector.<StringEnum>;
			_positions = new Dictionary;
		}
		
		public function get ids():Vector.<StringEnum>
		{
			return _keys;
		}
		
		public function registerPagePosition(id:StringEnum, point:Point):void
		{
			if (_keys.indexOf(id) == -1)
			{
				_keys.push(id);
			}
			_positions[id] = point;
		}
		
		override protected function openPageFinally(newPage:IPage):void
		{
			if (!_initialized)
			{
				_x = x;
				_y = y;
				_initialized = true;
			}
			
			_page = newPage;
			addChild(newPage.display);
			newPage.onOpened.addOnce(handlePageOpened);
			
			var pt:Point = _positions[newPage.id] as Point;
			newPage.display.x = pt.x;
			newPage.display.y = pt.y;
			
			eaze(this)
				.to(.5, { x: _x - pt.x, y: _y - pt.y } )
				.easing(Cubic.easeInOut)
				.onComplete(newPage.open);
		}
		
		override protected function removePageFinally():void
		{
			_page = null;
		}
	}
}