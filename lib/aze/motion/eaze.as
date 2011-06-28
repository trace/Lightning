/*
	Eaze is an Actionscript 3 tween library by Philippe Elsass
	Contact: philippe.elsass*gmail.com
	Website: http://code.google.com/p/eaze-tween/
	License: http://www.opensource.org/licenses/mit-license.php
*/
package aze.motion 
{
	/**
	 * Select a target for tweening
	 */
	public function eaze(target:Object):EazeTween
	{
		return new EazeTween(target);
	}

}
import aze.motion.specials.PropertyBezier;
import aze.motion.specials.PropertyColorMatrix;
import aze.motion.specials.PropertyFilter;
import aze.motion.specials.PropertyFrame;
import aze.motion.specials.PropertyShortRotation;
import aze.motion.specials.PropertyTint;
import aze.motion.specials.PropertyVolume;
// you can comment out the following lines to disable some plugins
 PropertyTint.register();
 PropertyFrame.register();
 PropertyFilter.register();
 PropertyVolume.register();
 PropertyColorMatrix.register();
 PropertyBezier.register();
 PropertyShortRotation.register();
