package za.co.skycorp.lightning.text.vo
{
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;

	/**
	 * @author Chris Truter
	 */
	public class BasicTextVO
	{
		public var align:String;
		public var antiAliasType:String;
		public var autoSize:String;
		public var bold:Boolean;
		public var colour:uint;
		public var embeddedFont:Boolean;
		public var fontName:Object;
		public var italic:Boolean;
		public var multiline:Boolean;
		public var wordWrap:Boolean;
		public var leading:Object;
		public var letterSpacing:Object
		public var selectable:Boolean;
		public var size:Object;
		public var underline:Boolean;

		public function BasicTextVO(fontName:Object, size:Object = 10, colour:uint = 0x0, bold:Boolean = false, italic:Boolean = false, underline:Boolean = false, selectable:Boolean = false, align:String = null, antiAliasType:String = null, autoSize:String = null, embeddedFont:Boolean = false, leading:Object = null, letterSpacing:Object = null)
		{
			this.fontName = fontName;
			this.size = size;
			this.colour = colour;
			this.bold = bold;
			this.italic = italic;
			this.underline = underline;
			this.selectable = selectable;
			this.align = align ? align : TextFormatAlign.LEFT;
			this.antiAliasType = antiAliasType ? antiAliasType : AntiAliasType.ADVANCED;
			this.autoSize = autoSize ? autoSize : TextFieldAutoSize.LEFT;
			this.embeddedFont = embeddedFont;
			this.leading = leading;
			this.letterSpacing = letterSpacing;
		}
	}
}