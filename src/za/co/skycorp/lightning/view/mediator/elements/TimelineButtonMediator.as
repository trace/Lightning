package za.co.skycorp.lightning.view.mediator.elements
{
	import org.robotlegs.mvcs.SignalMediator;
	import za.co.skycorp.lightning.controller.signals.SoundSignal;
	import za.co.skycorp.lightning.view.elements.buttons.TimelineButton;


	/**
	 * @author Ben-Piet O'Callaghan || Copyright 2011 GSDH
	 */
	public class TimelineButtonMediator extends SignalMediator
	{
		[Inject] public var view:TimelineButton;
		[Inject] public var sound:SoundSignal;
		
		override public function onRegister():void
		{
			view.sound = sound;
			super.onRegister();
		}

		override public function onRemove():void
		{
			view.sound = null;
			super.onRemove();
		}
	}
}