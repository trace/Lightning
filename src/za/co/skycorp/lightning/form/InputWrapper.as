package za.co.skycorp.lightning.form
{
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import za.co.skycorp.lightning.interfaces.IValidatable;


	/**
	 * @author Chris Truter
	 */
	public class InputWrapper extends Sprite implements IValidatable
	{
		public var field:TextField;
		private var _defaultText:String;
		private var _isEmail:Boolean;

		public function InputWrapper(field:TextField, isEmail:Boolean = false)
		{
			_isEmail = isEmail;

			this.field = field;
			field.embedFonts = true;
			_defaultText = field.text;
			field.parent.addChild(this);
			addChild(field);

			var tf:TextFormat = field.getTextFormat();
			tf.font = "Arial";
			field.setTextFormat(tf);
			field.defaultTextFormat = tf;

			field.addEventListener(FocusEvent.FOCUS_IN, handleFocusIn);
			field.addEventListener(FocusEvent.FOCUS_OUT, handleFocusOut);
		}

		public function reset():void
		{
			field.text = _defaultText;
			field.transform.colorTransform = new ColorTransform;
		}

		private function handleFocusIn(e:FocusEvent):void
		{
			transform.colorTransform = new ColorTransform;
			if (field.text == _defaultText)
				field.text = "";
		}

		private function handleFocusOut(e:FocusEvent):void
		{
			if (field.text == "")
				field.text = _defaultText;
		}

		public function validate():Boolean
		{
			if (field.text == "" || field.text == _defaultText)
			{
				transform.colorTransform = new ColorTransform(0, 0, 0, 1, 255);
				return false;
			}

			if (_isEmail && !field.text.match(/[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/i))
			{
				transform.colorTransform = new ColorTransform(0, 0, 0, 1, 255);
				return false;
			}

			transform.colorTransform = new ColorTransform;

			return true;
		}
	}
}