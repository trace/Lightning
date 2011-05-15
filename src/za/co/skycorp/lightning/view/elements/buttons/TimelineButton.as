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
	 * TODOM: rewrite this terrible awful class // 'M' for manguste
	 *
	 * @author Chris Truter
	 */
	public class TimelineButton extends Sprite
	{
		private const OUT_LABEL:String = "_out_";
		private const DOWN_LABEL:String = "_down_";
		private const DISABLED_LABEL:String = "_disabled_";
		private const SELECTED_LABEL:String = "_selected_";
		private const OVER_LABEL:String = "_over";
		// trunacted for compatability
		public var asset:MovieClip;
		public var sound:Signal;
		protected var _selected:Boolean;
		protected var _disabled:Boolean = false;
		protected var _status:Boolean;
		protected var _over:Boolean;
		protected var _isSelectable:Boolean = false;
		protected var _isDisableable:Boolean = false;
		protected var _onClick:Signal;
		private var _outFrame:int;
		private var _selectedFrame:int;
		private var _hasDown:Boolean = false;
		protected var _targetFrame:int;
		private var _soundClickID:SoundID;
		private var _soundOverID:SoundID;

		public function TimelineButton(graphic:MovieClip)
		{
			asset = graphic;
			soundClickID = SoundID.BUTTON_CLICK;
			soundOverID = SoundID.BUTTON_ROLL_OVER;

			// delegated for 1) JIT, 2) subclasses more flexible.
			if (asset)
				wrap();
			else
				throw(new Error("missing asset"));
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
			return _selected;
		}

		/**
		 * Changes the select state of the button
		 */
		public function set selected(newStatus:Boolean):void
		{
			if (_selected == newStatus)
				return;

			_selected = newStatus;

			if (!_isSelectable)
				return;

			switch (_selected)
			{
				case true:
					if (asset.currentLabel != SELECTED_LABEL)
						asset.gotoAndPlay(SELECTED_LABEL);
					else
						asset.gotoAndPlay(_selectedFrame);
					break;
				case false:
					if (_over)
						playSelectedBackwards();
					else
						asset.gotoAndPlay(OUT_LABEL);
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
			selected = _selected;
		}

		protected function handleClick(e:MouseEvent):void
		{
			while (hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, handleScrubBack);

			if (sound)
				sound.dispatch(SoundAction.PLAY, new SoundVO(soundClickID));

			if (_isSelectable)
				selected = !_selected;

			if (_selected)
				return;

			if (_onClick)
				_onClick.dispatch();
		}

		// ===============================================================
		// Handlers
		// ===============================================================
		protected function handleDown(evt:MouseEvent):void
		{
			if (_selected)
				return;

			if (_hasDown)
				asset.gotoAndPlay(DOWN_LABEL);
		}

		protected function handleOver(evt:MouseEvent):void
		{
			while (hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, handleScrubBack);

			_over = true;
			if (_selected)
				return;

			if (sound)
				sound.dispatch(SoundAction.PLAY, new SoundVO(soundOverID));

			asset.gotoAndPlay(2);
		}

		protected function handleOut(evt:MouseEvent):void
		{
			_over = false;
			if (_selected)
				return;
			asset.gotoAndPlay(OUT_LABEL);
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
				if (s.name == OUT_LABEL)
					_outFrame = s.frame;
				if (s.name == DOWN_LABEL)
					_hasDown = true;
				if (s.name == SELECTED_LABEL)
				{
					_selectedFrame = s.frame;
					_isSelectable = true;
				}
				if (s.name == DISABLED_LABEL)
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
			_selected = false;

			addEventListener(Event.ADDED_TO_STAGE, init);

			if (stage)
				init(null);

			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}

		private function activate():void
		{
			_disabled = false;

			// trace("activate", asset);

			if (_disabled)
				asset.gotoAndStop(OVER_LABEL);

			mouseEnabled = true;
			buttonMode = true;

			alpha = 1;

			addEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			addEventListener(MouseEvent.CLICK, handleClick);
			addEventListener(MouseEvent.ROLL_OVER, handleOver);
			addEventListener(MouseEvent.ROLL_OUT, handleOut);
		}

		private function deactivate():void
		{
			_disabled = true;
			if (_isDisableable)
				asset.gotoAndStop(DISABLED_LABEL);

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