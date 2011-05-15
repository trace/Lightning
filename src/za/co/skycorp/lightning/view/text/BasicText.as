package za.co.skycorp.lightning.view.text
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import za.co.skycorp.lightning.view.text.vo.BasicTextVO;


	/**
	 * @author Chris Truter
	 */
	public class BasicText extends TextField
	{
		private var _tf:TextFormat;

		public function BasicText(params:Object = null)
		{
			if (params == null)
				params = new BasicTextVO("Arial");

			_tf = new TextFormat(params.fontName, params.size, params.colour, params.bold, params.italic, params.underline, null, null, params.align, null, null, null, params.leading);
			_tf.letterSpacing = params.letterSpacing;

			setTextFormat(_tf);
			defaultTextFormat = _tf;

			autoSize = params.autoSize;
			selectable = params.selectable;
			antiAliasType = params.antiAliasType;
			embedFonts = params.embeddedFont;
			multiline = params.multiline;
			wordWrap = params.wordWrap;
		}
	}
}