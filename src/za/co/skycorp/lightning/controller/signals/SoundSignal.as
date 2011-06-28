package za.co.skycorp.lightning.controller.signals
{
	import org.osflash.signals.Signal;
	import za.co.skycorp.lightning.model.enum.SoundAction;
	import za.co.skycorp.lightning.model.enum.SoundID;
	import za.co.skycorp.lightning.model.vo.SoundVO;

	/**
	 * @author Chris Truter
	 */
	public class SoundSignal extends Signal
	{
		public function SoundSignal()
		{
			super(SoundAction, SoundVO);
		}
		
		public function loop(id:SoundID):void
		{
			dispatch(SoundAction.LOOP, new SoundVO(id));
		}
		
		public function loop_volume(vol:Number):void
		{
			dispatch(SoundAction.LOOP_VOLUME, new SoundVO(null, vol));
		}
		
		public function play(id:SoundID, vol:Number = -1):void
		{
			dispatch(SoundAction.PLAY, new SoundVO(id, vol));
		}
		
		public function stop(id:SoundID = null):void
		{
			dispatch(SoundAction.STOP, new SoundVO(id));
		}
		
		public function toggleMute():void
		{
			dispatch(SoundAction.TOGGLE_MUTE, new SoundVO);
		}
	}
}