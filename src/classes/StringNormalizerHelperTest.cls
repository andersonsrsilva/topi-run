/**
 * @author ercarval - Topi
 */
@isTest
private class StringNormalizerHelperTest {

    @isTest
    static void givenTextWithSpecialCharWhenNormalizedThenReplaceToCharWithoutDiacritics() {


        System.assertEquals( 'Aaaaa#' , StringNormalizerHelper.removeDiacritics ('Ããáàä#') );
    }

    @isTest
    static void givenTextWithSpecialCharAndNoTextCharWhenParsedThenReplaceToSpecialCharsByEmptyString () {
        System.assertEquals( '' , StringNormalizerHelper.removeSpecialChars ( StringNormalizerHelper.removeDiacritics ('�#') ) );
    }

    @isTest
    static void givenTextWithSpecialCharAndNoTextCharWhenNormalizedThenReplaceToCharWithoutDiacritics() {
        System.assertEquals( 'Aaaaa' ,  StringNormalizerHelper.removeSpecialCharsAndNormalize('�Ããáàä#')  );
    }

}