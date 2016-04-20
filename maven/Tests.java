package iut.tdd;

import java.util.Arrays;
import java.util.Collection;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

@RunWith(Parameterized.class)
public class Tests {
	@Parameters
	public static Collection<Object[]> data() {
		return Arrays.asList(new Object[][] { { "1", "I" }, { "2", "II" },
				{ "3", "III" }, { "4", "IV" }, { "5", "V" }, { "6", "VI" },
				{ "7", "VII" }, { "8", "VIII" }, { "9", "IX" }, { "10", "X" },
				{ "11", "XI" }, { "22", "XXII" }, { "33", "XXXIII" },
				{ "44", "XLIV" }, { "55", "LV" }, { "66", "LXVI" },
				{ "77", "LXXVII" }, { "88", "LXXXVIII" }, { "99", "XCIX" },
				{ "123", "CXXIII" }, { "234", "CCXXXIV" }, { "456", "CDLVI" },
				{ "567", "DLXVII" }, { "890", "DCCCXC" },
				{ "1357", "MCCCLVII" }, { "3579", "MMMDLXXIX" } });
	}

	private String roman;
	private String arabe;

	public Tests(String arabe, String roman) {
		this.arabe = arabe;
		this.roman = roman;
	}

	@Test
	public void testConvertToRoman() {
		Assert.assertEquals(roman, new RomanNumerals().convertToRoman(arabe));
	}
	
	@Test
	public void testConvertFromRoman() {
		Assert.assertEquals(arabe, new RomanNumerals().convertFromRoman(roman));
	}
}
