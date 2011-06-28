package test
{
	import asunit.textui.TestRunner;
	import flash.display.Stage;

	/**
	 * Run framework tests
	 * @author Chris Truter
	 */
	public class Main extends TestRunner
	{
		/**
		 * Needed for Event.ADDED_TO_STAGE, etc based tests.
		 */
		static public function get STAGE():Stage { return _stage; }
		
		static private var _stage:Stage;
		
		public function Main():void
		{
			_stage = stage;
			
			start(AllTests, null, TestRunner.SHOW_TRACE);
		}
	}
}