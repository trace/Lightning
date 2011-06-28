package test.models.proxies
{
	import asunit.framework.TestCase;
	import flash.media.SoundChannel;
	import test.stubs.sound.InvalidSound;
	import test.stubs.sound.ValidSound;
	import za.co.skycorp.lightning.model.enum.StringEnum;
	import za.co.skycorp.lightning.model.factories.SoundFactory;
	import za.co.skycorp.lightning.model.proxies.SoundProxy;
	
	/**
	 * TODO rename helper classes
	 * TODO async tests with actual sound playing
	 * TODO protection against
	 *
	 * @author Chris Truter
	 * date created 27/06/2011
	 */
	public class SoundProxyTest extends TestCase
	{
		private const ID:StringEnum = new StringEnum("id");
		
		public var soundProxy:SoundProxy;
		
		public function SoundProxyTest(method:String = null)
		{
			super(method);
		}
		
		override protected function setUp():void
		{
            super.setUp();
			soundProxy = new SoundProxy;
			soundProxy.factory = new SoundFactory;
        }
		
        override protected function tearDown():void
		{
			super.tearDown();
			soundProxy.destroy();
			soundProxy = null;
		}
		
		/** TESTS **/
		public function test_instantiated():void
		{
			assertTrue("instance created", soundProxy is SoundProxy);
		}
		
		public function test_invalid_sound():void
		{
			soundProxy.factory.registerClass(ID, InvalidSound);
			assertFalse("sound cannot play.", soundProxy.playSound(ID));
		}
		
		public function test_valid_sound():void
		{
			soundProxy.factory.registerClass(ID, ValidSound);
			assertTrue("sound can play.", soundProxy.playSound(ID));
		}
		
		public function test_valid_repeated_sound():void
		{
			soundProxy.factory.registerClass(ID, ValidSound);
			assertTrue("sound can play.", soundProxy.playSound(ID));
			assertTrue("sound can play.", soundProxy.playSound(ID));
		}
		
		public function test_missing_sound():void
		{
			assertFalse("sound cannot play.", soundProxy.playSound(ID));
		}
		
		public function test_valid_muted_sound():void
		{
			soundProxy.factory.registerClass(ID, ValidSound);
			soundProxy.toggleMute();
			assertFalse("sound cannot play when muted.", soundProxy.playSound(ID));
		}
		
		public function test_destroy():void
		{
			soundProxy.destroy();
			assertNull("factory is destroyed.", soundProxy.factory);
			// TODO test other data are destroyed - list, loop, strategy
		}
		
		public function test_valid_loop():void
		{
			soundProxy.factory.registerClass(ID, ValidSound);
			soundProxy.setLoop(ID);
			// TODO test actually does something..
		}
		
		public function test_invalid_loop():void
		{
			soundProxy.factory.registerClass(ID, InvalidSound);
			soundProxy.setLoop(ID);
			// TODO test doesn't actually do something..
		}
		
		public function test_stop_sound_nothing():void
		{
			soundProxy.stopSound(ID);
			// TODO test actually does something..
		}
		
		public function test_stop_sound_valid():void
		{
			soundProxy.factory.registerClass(ID, ValidSound);
			soundProxy.playSound(ID);
			soundProxy.stopSound(ID);
			// TODO test actually does something..
		}
		
		public function test_stop_sound_invalid():void
		{
			soundProxy.factory.registerClass(ID, InvalidSound);
			soundProxy.playSound(ID);
			soundProxy.stopSound(ID);
			// TODO test actually does something..
		}
		
		public function test_stop_sound_valid_all():void
		{
			soundProxy.factory.registerClass(ID, ValidSound);
			soundProxy.playSound(ID);
			soundProxy.stopSound();
			// TODO test actually does something..
		}
		
		public function test_stop_sound_invalid_all():void
		{
			soundProxy.factory.registerClass(ID, InvalidSound);
			soundProxy.playSound(ID);
			soundProxy.stopSound();
			// TODO test actually does something..
		}
		
		public function test_volume_value():void
		{
			soundProxy.sfxVolume = .5;
			assertEquals("volume is as set", soundProxy.sfxVolume, .5);
			soundProxy.sfxVolume = .7;
			assertEquals("volume is as set", soundProxy.sfxVolume, .7);
		}
		
		public function test_volume_sound():void
		{
			var sc:SoundChannel;
			soundProxy.sfxVolume = .5;
			soundProxy.factory.registerClass(ID, ValidSound);
			sc = soundProxy.playSound(ID);
			assertEquals("volume of sound without instruction matches pure volume", .5, sc.soundTransform.volume);
			sc = soundProxy.playSound(ID, .5);
			assertEquals("volume of sound without instruction matches pure volume", .25, sc.soundTransform.volume);
		}
		
		public function test_volume_ratio():void
		{
			soundProxy.volume = .5;
			assertEquals("loop volume is unscaled", .5, soundProxy.loopVolume);
			assertEquals("loop volume is scaled", Math.pow(.5, 1.4), soundProxy.sfxVolume);
		}
	}
}