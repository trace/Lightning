package za.co.skycorp.lightning.view.containers
{
	import flash.display.Sprite;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.view.interfaces.IPopup;
	import za.co.skycorp.lightning.view.interfaces.IResizable;

	/**
	 * FIX: support multiple popups - (Ben-Piet fixed me)
	 * FIX: allow enforcing single popups - (Ben-Piet broke me)
	 *
	 * @author Chris Truter
	 */
	public class PopupContainer extends Sprite implements IResizable
	{
		private var _popups:Vector.<IPopup>;
		private var _isCentred:Boolean = true;
		private var _isMulti:Boolean = false;
		
		public function PopupContainer()
		{
			_popups = new Vector.<IPopup>();
		}
		
		public function get isCentred():Boolean { return _isCentred; }
		public function set isCentred(value:Boolean):void { _isCentred = value; }
		
		public function get isMulti():Boolean { return _isMulti; }
		public function set isMulti(value:Boolean):void { _isMulti = value; }
		
		/* Return number of open popups. */
		public function get length():int { return _popups.length; }
		
		public function openPopup(popup:IPopup):void
		{
			// ignore repeats
			if (_popups.indexOf(popup) > -1)
				return;
				
			if (!_isMulti)
				closePopup(StringEnum.BLANK);
			_popups.push(popup);
			
			addChild(popup.display);
			if (stage) resize(stage.stageWidth, stage.stageHeight);
			popup.open();
		}
		
		/**
		 * Close page with given ID, if also open. Passing blank opens the first open popup.
		 * @param	id
		 * @return  false if nothing done, true otherwise
		 */
		public function closePopup(id:StringEnum):Boolean
		{
			if (_popups.length == 0)
				return false;
			// don't die.
			
			var idx:int = (id == StringEnum.BLANK) ? 0 : getIndex(id);
			if (idx < 0)
				return false;
			var popup:IPopup = _popups[idx];
			popup.close();
			
			return true;
		}
		
		private function getIndex(id:StringEnum):int
		{
			var index:int = -1;
			for (var i:int = 0; i < _popups.length; i++)
			{
				if (_popups[i].id == id)
					index = i;
			}
			return index;
		}
		
		public function resize(w:Number, h:Number):void
		{
			if (_isCentred)
			{
				for (var i:int = 0; i < _popups.length; i++)
				{
					var p:Sprite = _popups[i].display;
					p.x = int((w - p.width) * .5);
					p.y = int((h - p.height) * .5) - 100;
				}
			}
		}
		
		public function removePopup(id:StringEnum):void
		{
			var idx:int = getIndex(id);
			removeChild(_popups[idx].display);
			_popups.splice(idx, 1);
		}
	}
}