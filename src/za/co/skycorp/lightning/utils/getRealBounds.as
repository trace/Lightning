package za.co.skycorp.lightning.utils
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	/**
	 * Calculate the /real/ bounds of an object, ignoreing alpha-0 objects, for example.
	 *
	 * Refer: http://blog.open-design.be/2010/01/26/getbounds-on-displayobject-not-functioning-properly/
	 *
	 * @param	displayObject
	 * @return
	 */
	public function getRealBounds(displayObject:DisplayObject):Rectangle
	{
		var bounds:Rectangle;
		var boundsDispO:Rectangle = displayObject.getBounds(displayObject);

		var bitmapData:BitmapData = new BitmapData(int(boundsDispO.width + 0.5), int(boundsDispO.height + 0.5), true, 0);

		var matrix:Matrix = new Matrix();
		matrix.translate(-boundsDispO.x, -boundsDispO.y);

		bitmapData.draw(displayObject, matrix, new ColorTransform(1, 1, 1, 1, 255, -255, -255, 255));

		bounds = bitmapData.getColorBoundsRect(0xFF000000, 0xFF000000);
		bounds.x += boundsDispO.x;
		bounds.y += boundsDispO.y;

		bitmapData.dispose();
		return bounds;
	}
}