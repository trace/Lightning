package test.utils
{
	import asunit.framework.TestCase;
	import za.co.skycorp.lightning.utils.FormValidator;
	/**
	 * @author Chris Truter
	 * date created 28/06/2011
	 */
	public class FormValidatorTest extends TestCase
	{
		public function FormValidatorTest(method:String = null)
		{
			super(method);
		}
		
		public function test_validate_nonempty():void
		{
			assertFalse("empty string is not non empty", FormValidator.validateNonempty(""));
			assertFalse("all whitespace string is not non empty", FormValidator.validateNonempty("\t \n"));
			
			assertTrue("alpha is non empty", FormValidator.validateNonempty("a"));
			assertTrue("numeric is non empty", FormValidator.validateNonempty("1"));
			assertTrue("punctuation is non empty", FormValidator.validateNonempty("#"));
			
			assertTrue("longer strings are non empty", FormValidator.validateNonempty("asdf9 9asdf98 # "));
		}
		
		public function test_validate_email():void
		{
			// TODO load file with test suite.. eg http://code.google.com/p/php-email-address-validation/source/browse/trunk/tests/EmailAddressValidatorTest.php
			assertFalse("example is not valid", FormValidator.validateEmail("example"));
			assertFalse("example@me is not valid", FormValidator.validateEmail("example@me"));
			assertTrue("example@me.com is valid", FormValidator.validateEmail("example@me.com"));
		}
		
		public function test_postal_code():void
		{
			assertFalse(FormValidator.validatePostalCode("5"));
			assertFalse(FormValidator.validatePostalCode("50"));
			assertFalse(FormValidator.validatePostalCode("500"));
			assertFalse(FormValidator.validatePostalCode("5003"));
			assertFalse(FormValidator.validatePostalCode("500313"));
			
			assertFalse(FormValidator.validatePostalCode("5003a"));
			assertFalse(FormValidator.validatePostalCode("50031a"));
			
			assertTrue(FormValidator.validatePostalCode("50031"));
		}
	}
}