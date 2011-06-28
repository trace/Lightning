package test.view.elements.buttons
{
	import asunit.framework.TestCase;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import za.co.skycorp.lightning.view.elements.buttons.TimelineButton;
	/**
	 * TODO: lots more cases to test..
	 *
	 * @author Chris Truter
	 * date created 28/06/2011
	 */
	public class TimelineButtonTest extends TestCase
	{
		private var _button:TimelineButton;
		private var _asset:MovieClip; // should use a test asset
		
		public function TimelineButtonTest(method:String = null)
		{
			super(method);
		}
		
		override protected function setUp():void
		{
			super.setUp();
			_asset = new MovieClip;
			_button = new TimelineButton(_asset);
			_button.reset(); // simulate added to stage
		}
		
		override protected function tearDown():void
		{
			_button.destroy();
			_button = null;
			_asset = null;
			super.tearDown();
		}
		
		public function test_on_click():void
		{
			var hasBeenClicked:Boolean = false;
			_button.onClick.addOnce(function():void { hasBeenClicked = true; } );
			_button.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			assertTrue("onClick has fired", hasBeenClicked);
		}
		
		public function test_disable():void
		{
			_button.status = false;
			var hasBeenClicked:Boolean = false;
			_button.onClick.addOnce(function():void { hasBeenClicked = true; } );
			_button.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			assertFalse("onClick has not fired", hasBeenClicked);
		}
		
		public function test_enable():void
		{
			_button.status = false;
			_button.status = true;
			var hasBeenClicked:Boolean = false;
			_button.onClick.addOnce(function():void { hasBeenClicked = true; } );
			_button.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			assertTrue("onClick has fired", hasBeenClicked);
		}
		
		public function test_remember_state_off_stage():void
		{
			var _stage:Stage = LightningTests.STAGE;
			_stage.addChild(_button);
			_button.status = false;
			_stage.removeChild(_button);
			_stage.addChild(_button);
			assertFalse("button still disabled", _button.status);
			
			_button.status = true;
			_stage.removeChild(_button);
			_stage.addChild(_button);
			assertTrue("button still enabled", _button.status);
		}
		
		public function test_disabled_off_stage():void
		{
			var _stage:Stage = LightningTests.STAGE;
			_stage.addChild(_button);
			_button.status = true;
			_stage.removeChild(_button);
			
			var hasBeenClicked:Boolean = false;
			_button.onClick.addOnce(function():void { hasBeenClicked = true; } );
			_button.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			assertFalse("onClick has not fired", hasBeenClicked);
		}
		
		public function test_visual():void
		{
			// load a bunch of example assets from a swc here,
			// display on stage for user to test
		}
	}
}