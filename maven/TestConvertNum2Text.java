package iut.tdd;

import org.junit.Assert;
import org.junit.Test;

public class TestConvertNum2Text {

	@Test
	public void test_zero_dix() {
		Assert.assertEquals("zéro", Convert.num2text("0"));
		Assert.assertEquals("un", Convert.num2text("1"));
		Assert.assertEquals("deux", Convert.num2text("2"));
		Assert.assertEquals("trois", Convert.num2text("3"));
		Assert.assertEquals("quatre", Convert.num2text("4"));
		Assert.assertEquals("cinq", Convert.num2text("5"));
		Assert.assertEquals("six", Convert.num2text("6"));
		Assert.assertEquals("sept", Convert.num2text("7"));
		Assert.assertEquals("huit", Convert.num2text("8"));
		Assert.assertEquals("neuf", Convert.num2text("9"));
	}

	@Test
	public void test_dix() {
		Assert.assertEquals("dix", Convert.num2text("10"));
		Assert.assertEquals("onze", Convert.num2text("11"));
		Assert.assertEquals("douze", Convert.num2text("12"));
		Assert.assertEquals("treize", Convert.num2text("13"));
		Assert.assertEquals("quatorze", Convert.num2text("14"));
		Assert.assertEquals("quinze", Convert.num2text("15"));
		Assert.assertEquals("seize", Convert.num2text("16"));
		Assert.assertEquals("dix-sept", Convert.num2text("17"));
		Assert.assertEquals("dix-huit", Convert.num2text("18"));
		Assert.assertEquals("dix-neuf", Convert.num2text("19"));
	}

	@Test
	public void test_vingt() {
		Assert.assertEquals("vingt", Convert.num2text("20"));
		Assert.assertEquals("vingt et un", Convert.num2text("21"));
		Assert.assertEquals("vingt-deux", Convert.num2text("22"));
		Assert.assertEquals("vingt-trois", Convert.num2text("23"));
		Assert.assertEquals("vingt-quatre", Convert.num2text("24"));
		Assert.assertEquals("vingt-cinq", Convert.num2text("25"));
		Assert.assertEquals("vingt-six", Convert.num2text("26"));
		Assert.assertEquals("vingt-sept", Convert.num2text("27"));
		Assert.assertEquals("vingt-huit", Convert.num2text("28"));
		Assert.assertEquals("vingt-neuf", Convert.num2text("29"));
	}

	@Test
	public void test_dixaines() {
		Assert.assertEquals("trente", Convert.num2text("30"));
		Assert.assertEquals("quarante", Convert.num2text("40"));
		Assert.assertEquals("cinquante", Convert.num2text("50"));
	}

	@Test
	public void test_presque_soixante() {
		Assert.assertEquals("soixante", Convert.num2text("60"));
		Assert.assertEquals("soixante et un", Convert.num2text("61"));
		Assert.assertEquals("soixante-deux", Convert.num2text("62"));
		Assert.assertEquals("soixante-trois", Convert.num2text("63"));
		Assert.assertEquals("soixante-quatre", Convert.num2text("64"));
		Assert.assertEquals("soixante-cinq", Convert.num2text("65"));
		Assert.assertEquals("soixante-six", Convert.num2text("66"));
		Assert.assertEquals("soixante-sept", Convert.num2text("67"));
		Assert.assertEquals("soixante-huit", Convert.num2text("68"));
		Assert.assertEquals("soixante-neuf", Convert.num2text("69"));
	}

	@Test
	public void test_soixante_dix() {
		Assert.assertEquals("soixante-dix", Convert.num2text("70"));
		Assert.assertEquals("soixante et onze", Convert.num2text("71"));
		Assert.assertEquals("soixante-douze", Convert.num2text("72"));
		Assert.assertEquals("soixante-treize", Convert.num2text("73"));
		Assert.assertEquals("soixante-quatorze", Convert.num2text("74"));
		Assert.assertEquals("soixante-quinze", Convert.num2text("75"));
		Assert.assertEquals("soixante-seize", Convert.num2text("76"));
		Assert.assertEquals("soixante-dix-sept", Convert.num2text("77"));
		Assert.assertEquals("soixante-dix-huit", Convert.num2text("78"));
		Assert.assertEquals("soixante-dix-neuf", Convert.num2text("79"));
	}

	@Test
	public void test_quatre_vingts() {
		Assert.assertEquals("quatre-vingts", Convert.num2text("80"));
		Assert.assertEquals("quatre-vingt-un", Convert.num2text("81"));
		Assert.assertEquals("quatre-vingt-deux", Convert.num2text("82"));
		Assert.assertEquals("quatre-vingt-trois", Convert.num2text("83"));
		Assert.assertEquals("quatre-vingt-quatre", Convert.num2text("84"));
		Assert.assertEquals("quatre-vingt-cinq", Convert.num2text("85"));
		Assert.assertEquals("quatre-vingt-six", Convert.num2text("86"));
		Assert.assertEquals("quatre-vingt-sept", Convert.num2text("87"));
		Assert.assertEquals("quatre-vingt-huit", Convert.num2text("88"));
		Assert.assertEquals("quatre-vingt-neuf", Convert.num2text("89"));
	}

	@Test
	public void test_quatre_vingt_dix() {
		Assert.assertEquals("quatre-vingt-dix", Convert.num2text("90"));
		Assert.assertEquals("quatre-vingt-onze", Convert.num2text("91"));
		Assert.assertEquals("quatre-vingt-douze", Convert.num2text("92"));
		Assert.assertEquals("quatre-vingt-treize", Convert.num2text("93"));
		Assert.assertEquals("quatre-vingt-quatorze", Convert.num2text("94"));
		Assert.assertEquals("quatre-vingt-quinze", Convert.num2text("95"));
		Assert.assertEquals("quatre-vingt-seize", Convert.num2text("96"));
		Assert.assertEquals("quatre-vingt-dix-sept", Convert.num2text("97"));
		Assert.assertEquals("quatre-vingt-dix-huit", Convert.num2text("98"));
		Assert.assertEquals("quatre-vingt-dix-neuf", Convert.num2text("99"));
	}

	@Test
	public void test_cent() {
		Assert.assertEquals("cent", Convert.num2text("100"));
		Assert.assertEquals("cent dix", Convert.num2text("110"));
		Assert.assertEquals("cent treize", Convert.num2text("113"));
		Assert.assertEquals("cent trente-deux", Convert.num2text("132"));
		Assert.assertEquals("cent quarante-neuf", Convert.num2text("149"));
		Assert.assertEquals("cent quatre-vingt-dix-huit", Convert.num2text("198"));
		Assert.assertEquals("deux cents", Convert.num2text("200"));
		Assert.assertEquals("quatre cents", Convert.num2text("400"));
		Assert.assertEquals("quatre cent vingt et un", Convert.num2text("421"));
		Assert.assertEquals("quatre cent trente-neuf", Convert.num2text("439"));
		Assert.assertEquals("cinq cents", Convert.num2text("500"));
		Assert.assertEquals("neuf cent quatre-vingt-dix-neuf", Convert.num2text("999"));
	}

	@Test
	public void test_space() {
		Assert.assertEquals("cent", Convert.num2text(" 100"));
		Assert.assertEquals("cent dix", Convert.num2text("110 "));
		Assert.assertEquals("cent treize", Convert.num2text("  113  "));
	}

	@Test
	public void test_mille() {
		Assert.assertEquals("mille", Convert.num2text("1000"));
		Assert.assertEquals("mille", Convert.num2text("1 000"));
	}

	@Test
	public void test_euro() {
		Assert.assertEquals("cent euros", Convert.num2text("100 €"));
		Assert.assertEquals("trois euros cinquante", Convert.num2text("3,5 €"));
		Assert.assertEquals("un euro quarante et un", Convert.num2text("1.41 €"));
	}

	@Test
	public void test_euro_espace() {
		Assert.assertEquals("cent euros", Convert.num2text("100€"));
	}

	@Test
	public void test_dollar() {
		Assert.assertEquals("cent dollars", Convert.num2text("$ 100"));
		Assert.assertEquals("un dollar quarante et un", Convert.num2text("1,41 $"));
	}

	@Test
	public void test_dollar_US() {
		Assert.assertEquals("cent dollars", Convert.num2text("$100"));
	}
	
	@Test
	public void test_dollar_point() {
		Assert.assertEquals("trois dollars cinquante", Convert.num2text("$3.5"));
	}

	@Test
	public void test_dollar_US_espace () {
		Assert.assertEquals("cent dollars", Convert.num2text("$ 100"));
	}

	@Test
	public void test_keuros() {
		Assert.assertEquals("deux mille euros", Convert.num2text("2 k€"));
	}

	@Test
	public void test_keuros_virgule() {
		Assert.assertEquals("trois mille cinq cents euros", Convert.num2text("3,5 k€"));
	}
	
	@Test
	public void test_livre() {
		Assert.assertEquals("trois livres", Convert.num2text("3 £"));
	}

	@Test
	public void test_yen() {
		Assert.assertEquals("deux yen", Convert.num2text("2 ¥"));
	}

}
