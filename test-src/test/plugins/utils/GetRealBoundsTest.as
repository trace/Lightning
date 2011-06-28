package test.plugins.utils {
	import asunit.framework.TestCase;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import za.co.skycorp.lightning.utils.getRealBounds;


	/**
	 * @author Chris Truter
	 */
	public class GetRealBoundsTest extends TestCase
	{
		public function GetRealBoundsTest(method:String = null)
		{
			super(method);
		}
		
		override protected function setUp():void
		{
            super.setUp();
        }

        override protected function tearDown():void
		{
			super.tearDown();
		}
		
		public function testIgnoreOutsideMask():void
		{
			assertTrue("calculation ignores masked portion.", false);
		}
		
		public function testSquare():void
		{
			var shape:Shape = new Shape;
			var r:Rectangle = new Rectangle(12, 34, 40, 50);
			shape.graphics.beginFill(0x0);
			shape.graphics.drawRect(r.x, r.y, r.width, r.height);
			shape.graphics.endFill();
			var r2:Rectangle = getRealBounds(shape);
			assertTrue("calculates rectangle bounds correctly.", r2.equals(r));
		}
		
		public function testCircle():void
		{
			var shape:Shape = new Shape;
			var r:Rectangle = new Rectangle(-5, -5, 10, 10);
			shape.graphics.beginFill(0x0);
			shape.graphics.drawCircle(0, 0, 5);
			shape.graphics.endFill();
			var r2:Rectangle = getRealBounds(shape);
			// TODO: fix this inaccuracy
			//r.height -= 1;
			
			trace(r2, r);
			
			assertTrue("calculates circle bounds correctly.", r2.equals(r));
		}
		
		public function testStar():void
		{
			assertTrue("calculates irregular bounds correctly.", false);
		}
		
		public function testRotationScale():void
		{
			assertTrue("calculates bounds correctly under nested rotations and scaling.", false);
		}
	}
}