package test.view.core
{
	import asunit.framework.TestCase;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import test.Main;
	import za.co.skycorp.lightning.view.core.Application;
	/**
	 * @author Chris Truter
	 * date created 28/06/2011
	 */
	public class ApplicationTest extends TestCase
	{
		private var application:Application;
		private var s:Sprite;
		private var s2:Sprite;
		
		public function ApplicationTest(method:String = null)
		{
			super(method);
			
			// test logging
			// test stats
			// test debugging
			// test initialization
		}
		
		override protected function setUp():void
		{
			super.setUp();
			application = new Application;
			Main.STAGE.addChild(application);
		}
		
		override protected function tearDown():void
		{
			application.destroy();
			application = null;
			s = null;
			s2 = null;
		}
		
		public function test_reveal_only_if_debugging():void
		{
			setUpRevealTest(false);
			s.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			assertEquals("item is unmarked", 0, s.filters.length);
		}
		
		public function test_stop_debugging_turns_off_reveal():void
		{
			setUpRevealTest();
			application.isDebugging = false;
			s.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			assertEquals("item is unmarked", 0, s.filters.length);
		}
		
		public function test_reveal_colours_item():void
		{
			setUpRevealTest();
			
			s.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			
			assertEquals("item has a filter", 1, s.filters.length);
			assertTrue("filter is colormatrix)", s.filters[0] is ColorMatrixFilter);
			assertNotSame("colormatrix is not identity (marked)", 1, ColorMatrixFilter(s.filters[0]).matrix[0]);
		}
		
		public function test_hide_reveal_colours_item():void
		{
			setUpRevealTest();
			
			s.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			s.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			
			var plainFilter:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
			
			assertEquals("item has a filter", 1, s.filters.length);
			assertTrue("filter is colormatrix", s.filters[0] is ColorMatrixFilter);
			assertEqualsArrays("colormatrix is identity (unmarked)", plainFilter, ColorMatrixFilter(s.filters[0]).matrix);
		}
		
		public function test_reveal_colours_item_again():void
		{
			setUpRevealTest();
			
			s.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			s.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			s.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			
			assertEquals("item has a filter", 1, s.filters.length);
			assertTrue("filter is colormatrix)", s.filters[0] is ColorMatrixFilter);
			assertNotSame("colormatrix is not identity (marked)", 1, ColorMatrixFilter(s.filters[0]).matrix[0]);
		}
		
		public function test_reveal_chains_correctly():void
		{
			setUpRevealTest();
			
			s.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			s2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			
			var plainFilter:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
			
			// s1 is not revealed
			assertEquals("item has a filter", 1, s.filters.length);
			assertTrue("filter is colormatrix", s.filters[0] is ColorMatrixFilter);
			assertEqualsArrays("colormatrix is identity (unmarked)", plainFilter, ColorMatrixFilter(s.filters[0]).matrix);
			
			// s2 is revealed
			assertEquals("item has a filter", 1, s2.filters.length);
			assertTrue("filter is colormatrix)", s2.filters[0] is ColorMatrixFilter);
			assertNotSame("colormatrix is not identity (marked)", 1, ColorMatrixFilter(s2.filters[0]).matrix[0]);
		}
		
		public function test_deactivate_reveal_item():void
		{
			setUpRevealTest();
			
			s.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			
			toggleRevealing();
			
			var plainFilter:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
			
			// revealed item was deactivated
			assertEquals("item has a filter", 1, s.filters.length);
			assertTrue("filter is colormatrix", s.filters[0] is ColorMatrixFilter);
			assertEqualsArrays("colormatrix is identity (unmarked)", plainFilter, ColorMatrixFilter(s.filters[0]).matrix);
			
			// listener is disabled
			s2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			assertEquals("item has no filter", 0, s2.filters.length);
		}
		
		private function setUpRevealTest(debug:Boolean = true):void
		{
			s = new Sprite;
			s2 = new Sprite;
			application.isDebugging = debug;
			application.addChild(s);
			application.addChild(s2);
			toggleRevealing();
		}
		
		private function toggleRevealing():void
		{
			Main.STAGE.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, false, false, 0, 82));
		}
	}
}