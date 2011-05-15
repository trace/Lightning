package za.co.skycorp.lightning.view.elements.buttons
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import za.co.skycorp.lightning.model.enum.SoundAction;
	import za.co.skycorp.lightning.model.enum.SoundID;
	import za.co.skycorp.lightning.model.vo.SoundVO;

	/**
	 * TODOM: rewrite this terrible awful class
	 *
	 * @author Chris Truter
	 */
	public class TimelineButton extends Sprite
	{
		// constants
		private const LABEL_DISABLED:String = "_disabled_";
		private const LABEL_DOWN:String = "_down_";
		private const LABEL_OUT:String = "_out_";
		private const LABEL_OVER:String = "_over";
		private const LABEL_SELECTED:String = "_selected_";		
		// public
		public var asset:MovieClip;
		public var sound:Signal;
		// protected
		protected var _isSelectable:Boolean;
		protected var _isSelected:Boolean;
		protected var _isDisableable:Boolean;
		protected var _isDisabled:Boolean;
		protected var _onClick:Signal;
		protected var _over:Boolean;
		protected var _status:Boolean;
		protected var _targetFrame:int;
		// private
		private var _hasDown:Boolean = false;
		private var _outFrame:int;
		private var _soundClickID:SoundID;
		private var _soundOverID:SoundID;
		private var _selectedFrame:int;

		public function TimelineButton(graphic:MovieClip)
		{
			asset = graphic;
			soundClickID = SoundID.BUTTON_CLICK;
			soundOverID = SoundID.BUTTON_ROLL_OVER;

			if (asset) wrap();
			else throw(new Error("missing asset"));
		}

		public function get soundClickID():SoundID
		{
			return _soundClickID;
		}

		public function set soundClickID(value:SoundID):void
		{
			_soundClickID = value;
		}

		public function get soundOverID():SoundID
		{
			return _soundOverID;
		}

		public function set soundOverID(value:SoundID):void
		{
			_soundOverID = value;
		}

		public function get status():Boolean
		{
			return _status;
		}

		/**
		 * Activates or deactivates the button.
		 */
		public function set status(newStatus:Boolean):void
		{
			_status = newStatus;
			_status ? activate() : deactivate();
		}

		public function get selected():Boolean
		{
			return _isSelected;
		}

		/**
		 * Changes the select state of the button
		 */
		public function set selected(newStatus:Boolean):void
		{
			if (_isSelected == newStatus)
				return;

			_isSelected = newStatus;

			if (!_isSelectable)
				return;

			switch (_isSelected)
			{
				case true:
					if (asset.currentLabel != LABEL_SELECTED)
						asset.gotoAndPlay(LABEL_SELECTED);
					else
						asset.gotoAndPlay(_selectedFrame);
					break;
				case false:
					if (_over)
						playSelectedBackwards();
					else
						asset.gotoAndPlay(LABEL_OUT);
					break;
			}
		}

		public function get onClick():ISignal
		{
			return _onClick ||= new Signal;
		}

		/**
		 * Called when removed from stage.
		 * @param	event:Event.REMOVED_FROM_STAGE
		 */
		public function destroy(evt:Event = null):void
		{
			deactivate();
		}

		/**
		 * Resets the button to it's initial state
		 */
		public function reset():void
		{
			status = _status;
			selected = _isSelected;
		}

		protected function handleClick(e:MouseEvent):void
		{
			while (hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, handleScrubBack);

			if (sound)
				sound.dispatch(SoundAction.PLAY, new SoundVO(soundClickID));

			if (_isSelectable)
				selected = !_isSelected;

			if (_isSelected)
				return;

			if (_onClick)
				_onClick.dispatch();
		}

		// ===============================================================
		// Handlers
		// ===============================================================
		protected function handleDown(evt:MouseEvent):void
		{
			if (_isSelected)
				return;

			if (_hasDown)
				asset.gotoAndPlay(LABEL_DOWN);
		}

		protected function handleOver(evt:MouseEvent):void
		{
			while (hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, handleScrubBack);

			_over = true;
			if (_isSelected)
				return;

			if (sound)
				sound.dispatch(SoundAction.PLAY, new SoundVO(soundOverID));

			asset.gotoAndPlay(2);
		}

		protected function handleOut(evt:MouseEvent):void
		{
			_over = false;
			if (_isSelected)
				return;
			asset.gotoAndPlay(LABEL_OUT);
		}

		protected function wrap():void
		{
			if (asset.parent)
				asset.parent.addChildAt(this, asset.parent.getChildIndex(asset));
			addChild(asset);

			asset.addFrameScript(0, asset.stop);
			asset.gotoAndStop(1);

			for each (var s:FrameLabel in asset.currentLabels)
			{
				if (s.name == LABEL_OUT)
					_outFrame = s.frame;
				if (s.name == LABEL_DOWN)
					_hasDown = true;
				if (s.name == LABEL_SELECTED)
				{
					_selectedFrame = s.frame;
					_isSelectable = true;
				}
				if (s.name == LABEL_DISABLED)
				{
					_isDisableable = true;
					asset.addFrameScript(s.frame - 3, asset.stop);
				}
				asset.addFrameScript(s.frame - 2, asset.stop);
			}

			mouseChildren = false;
			tabEnabled = false;
			buttonMode = true;

			_status = true;
			_isSelected = false;

			addEventListener(Event.ADDED_TO_STAGE, init);

			if (stage)
				init(null);

			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}

		private function activate():void
		{
			_isDisabled = false;
			if (_isDisableable && _isDisabled)
				asset.gotoAndStop(LABEL_OVER);

			alpha = 1;
			mouseEnabled = true;
			buttonMode = true;

			addEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			addEventListener(MouseEvent.CLICK, handleClick);
			addEventListener(MouseEvent.ROLL_OVER, handleOver);
			addEventListener(MouseEvent.ROLL_OUT, handleOut);
		}

		private function deactivate():void
		{
			_isDisabled = true;
			if (_isDisableable)
				asset.gotoAndStop(LABEL_DISABLED);

			alpha = .8;
			mouseEnabled = false;
			buttonMode = false;

			removeEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			removeEventListener(MouseEvent.CLICK, handleClick);
			removeEventListener(MouseEvent.ROLL_OVER, handleOver);
			removeEventListener(MouseEvent.ROLL_OUT, handleOut);
		}

		private function handleScrubBack(e:Event):void
		{
			asset.gotoAndStop(asset.currentFrame - 1);
			if (asset.currentFrame == _targetFrame)
			{
				removeEventListener(Event.ENTER_FRAME, handleScrubBack);
				if (_targetFrame == _selectedFrame)	
					asset.gotoAndStop(_outFrame - 1);
				else 
					asset.gotoAndStop(_targetFrame);
			}
		}

		/**
		 * Initialization method of the button.
		 * Called when added to stage.
		 * @param	event:Event.ADDED_TO_STAGE
		 */
		private function init(evt:Event):void
		{
			reset();
		}

		private function playSelectedBackwards():void
		{
			asset.stop();
			_targetFrame = _selectedFrame;
			addEventListener(Event.ENTER_FRAME, handleScrubBack);
		}
	}
}