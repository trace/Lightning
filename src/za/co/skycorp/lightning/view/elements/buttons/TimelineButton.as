package za.co.skycorp.lightning.view.elements.buttons
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.hires.debug.Logger;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import za.co.skycorp.lightning.interfaces.IDestroyable;
	import za.co.skycorp.lightning.model.enum.SoundAction;
	import za.co.skycorp.lightning.model.enum.SoundID;
	import za.co.skycorp.lightning.model.enum.TimelineButtonLabel;
	import za.co.skycorp.lightning.model.vo.SoundVO;
	import za.co.skycorp.lightning.utils.safelyRemoveChild;

	/**
	 * TODOM: rewrite this terrible awful class
	 * @author Chris Truter
	 */
	public class TimelineButton extends Sprite implements IDestroyable
	{
		// public
		public var asset:MovieClip;
		public var sound:Signal;
		public var soundClickID:SoundID;
		public var soundOverID:SoundID;
		// protected
		protected var _canDisable:Boolean;
		protected var _canSelect:Boolean;
		protected var _isActive:Boolean;
		protected var _isDisabled:Boolean;
		protected var _isOver:Boolean;
		protected var _isSelected:Boolean;
		protected var _onClick:Signal;
		protected var _targetFrame:int;
		// private
		private var _hasDownFrame:Boolean = false;
		private var _outFrame:int;
		private var _selectedFrame:int;
		
		public function TimelineButton(graphic:MovieClip)
		{
			asset = graphic;
			soundClickID = SoundID.BUTTON_CLICK;
			soundOverID = SoundID.BUTTON_ROLL_OVER;
			
			if (asset) wrap();
			else throw(new Error("missing asset"));
		}
		
		public function get onClick():ISignal {	return _onClick ||= new Signal; }
		
		public function get selected():Boolean { return _isSelected; }
		/* Changes the selected state of the button */
		public function set selected(newStatus:Boolean):void {
			if (_canSelect) setSelected(newStatus);
		}
		
		public function get status():Boolean { return _isActive; }
		/* Activates or deactivates the button. */
		public function set status(newStatus:Boolean):void {
			_isActive = newStatus;
			_isActive ? activate() : deactivate();
		}
		
		/**
		 * Resets the button to it's initial state
		 */
		public function reset():void
		{
			status = _isActive;
			selected = _isSelected;
		}
		
		protected function handleClick(e:MouseEvent):void
		{
			while (hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, handleScrubBack);
				
			if (sound) sound.dispatch(SoundAction.PLAY, new SoundVO(soundClickID));
			if (_canSelect) selected = !_isSelected;
			// TODO -> huh? not sure why doing this
			if (_isSelected) return;
			if (_onClick) _onClick.dispatch();
		}
		
		protected function handleDown(evt:MouseEvent):void
		{
			if (_isSelected) return;
			if (_hasDownFrame) asset.gotoAndPlay(TimelineButtonLabel.LABEL_DOWN);
		}
		
		protected function handleOver(evt:MouseEvent):void
		{
			while (hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, handleScrubBack);
				
			_isOver = true;
			if (_isSelected) return;
			if (sound) sound.dispatch(SoundAction.PLAY, new SoundVO(soundOverID));
			asset.gotoAndPlay(TimelineButtonLabel.LABEL_OVER);
		}
		
		protected function handleOut(evt:MouseEvent):void
		{
			_isOver = false;
			if (_isSelected) return;
			asset.gotoAndPlay(TimelineButtonLabel.LABEL_OUT);
		}
		
		protected function wrap():void
		{
			if (asset.parent)
			{
				var index:int = asset.parent.getChildIndex(asset)
				asset.parent.addChildAt(this, index);
			}
			addChild(asset);
			
			asset.addFrameScript(0, asset.stop);
			asset.gotoAndStop(1);
			
			for each (var s:FrameLabel in asset.currentLabels)
			{
				var isStopLabel:Boolean = true;
				switch(s.name)
				{
					case TimelineButtonLabel.LABEL_OUT:
						_outFrame = s.frame;
						break;
					case TimelineButtonLabel.LABEL_DOWN:
						_hasDownFrame = true;
						break;
					case TimelineButtonLabel.LABEL_SELECTED:
						_selectedFrame = s.frame;
						_canSelect = true;
						break;
					case TimelineButtonLabel.LABEL_DISABLED:
						_canDisable = true;
						asset.addFrameScript(s.frame - 3, asset.stop);
						break;
						
					default:
						// hmm, don't really care about extra labels, but log in case typo
						// also deactivate stop
						isStopLabel = false;
						Logger.debug("unknown timeline button label: " + s.name);
				}
				
				if (isStopLabel)
					asset.addFrameScript(s.frame - 2, asset.stop);
			}
			
			mouseChildren = false;
			tabEnabled = false;
			buttonMode = true;
			
			_isActive = true;
			_isSelected = false;
			
			if (stage)
				init(null);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
		}
		
		private function activate():void
		{
			if (_isDisabled) // should probably just check mouse actually..
			{
				_isDisabled = false;
				asset.gotoAndStop(TimelineButtonLabel.LABEL_OVER);
			}
				
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
			if (_canDisable)
			{
				_isDisabled = true;
				asset.gotoAndStop(TimelineButtonLabel.LABEL_DISABLED);
			}
				
			alpha = .8;
			mouseEnabled = false;
			buttonMode = false;
			
			removeEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			removeEventListener(MouseEvent.CLICK, handleClick);
			removeEventListener(MouseEvent.ROLL_OVER, handleOver);
			removeEventListener(MouseEvent.ROLL_OUT, handleOut);
		}
		
		private function handleRemovedFromStage(evt:Event = null):void
		{
			deactivate();
		}
		
		private function handleScrubBack(e:Event):void
		{
			if (asset.currentFrame != _targetFrame && asset.currentFrame > 1)
			{
				asset.gotoAndStop(asset.currentFrame - 1);
			}
			else
			{
				// here for safety if just played back past start
				asset.gotoAndStop(_targetFrame);
				removeEventListener(Event.ENTER_FRAME, handleScrubBack);
				// jump frames to simplify later logic, if on "deselect to off" frame
				if (_targetFrame == _selectedFrame)
					asset.gotoAndStop(_outFrame - 1);
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
		
		private function setSelected(newStatus:Boolean):void
		{
			if (_isSelected == newStatus || !_canSelect) return;
			
			_isSelected = newStatus;
			switch (_isSelected)
			{
				case true:
					asset.gotoAndStop(_selectedFrame);
					break;
				case false:
					asset.gotoAndPlay(_outFrame);
				
					// hmm not sure about this either.. remove and test on live assets
					//if (_isOver)
						//playSelectedBackwards();
					//else
						//asset.gotoAndPlay(TimelineButtonLabel.LABEL_OUT);
					break;
			}
		}
		
		public function destroy():void
		{
			deactivate();
			
			asset = null;
			soundClickID = null;
			soundOverID = null;
			_onClick = null;
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
			
			safelyRemoveChild(asset);
			safelyRemoveChild(this);
		}
	}
}