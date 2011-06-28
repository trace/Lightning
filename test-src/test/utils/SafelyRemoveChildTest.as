package test.utils
{
	import asunit.framework.TestCase;
	import flash.display.Sprite;
	import za.co.skycorp.lightning.utils.safelyRemoveChild;
	/**
	 * @author Chris Truter
	 * date created 28/06/2011
	 */
	public class SafelyRemoveChildTest extends TestCase
	{
		private var _parent:Sprite;
		private var _child:Sprite;
		
		public function SafelyRemoveChildTest(method:String = null)
		{
			super(method);
		}
		
		override protected function setUp():void
		{
			super.setUp();
			_parent = new Sprite;
			_child = new Sprite;
		}
		
		override protected function tearDown():void
		{
			super.tearDown();
			
			while (_parent.numChildren > 0)
				_parent.removeChildAt(_parent.numChildren - 1);
			_parent = null;
			_child = null;
		}
		
		public function test_safe_with_void_parent():void
		{
			assertFalse("nothing without parent", safelyRemoveChild(_child));
		}
		
		public function test_safe_with_void_child():void
		{
			assertFalse("nothing without child", safelyRemoveChild(null));
		}
		
		public function test_works_in_safe_limit():void
		{
			_parent.addChild(_child);
			assertTrue("action occurs when child ahs parent", safelyRemoveChild(_child));
			assertNull("child is now orphaned", _child.parent);
		}
	}
}