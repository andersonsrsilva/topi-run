/**
 *
 * @author ercarval - Topi
 */
@isTest
public class StringHelperTest {

    @isTest
    public static void givenValueThenApplyNullEvaluationConvertToEmpty () {

        System.assert( StringHelper.nullToEmpty( null ) == '' );
        System.assert( StringHelper.nullToEmpty( '' ) == '' );
        System.assert( StringHelper.nullToEmpty( 'null' ) == 'null' );

    }

    @isTest
    public static void onFirstIsEmptyUseOtherValueTest () {
   
        System.assert( StringHelper.useFirstOrSecond(null, 'Second') == 'Second' ); 
        System.assert( StringHelper.useFirstOrSecond('', 'Second') == 'Second' ); 
        System.assert( StringHelper.useFirstOrSecond('First', '') == 'First' ); 

        System.assert( StringHelper.useFirstOrSecond(null, 10.00) == 10.00 ); 
        System.assert( StringHelper.useFirstOrSecond(11.10, 1.10) == 11.10 ); 
   
    }


    @isTest
    public static void givenTwoValuesWhenCompareFirstIsEmptyOrEqualsSecondValueThenReturnComparation () {

        System.assert( StringHelper.isEmptyOr(null, 'Processed')); 
        System.assert( StringHelper.isEmptyOr('', 'Processed')); 
        System.assert( StringHelper.isEmptyOr('Processed', 'Processed')); 
        System.assert( !StringHelper.isEmptyOr('Processed', 'Queued')); 
   
    }


    @isTest
    public static void givenNumberValuesWhenTryToConvertToStringThenConvertSafely () {
        Integer nullInt = null;
        Integer nullLong = null;
        Integer nullDecimal = null;

        System.assert( StringHelper.toString(nullInt) == ''); 
        System.assert( StringHelper.toString(10) == '10'); 
        System.assert( StringHelper.toString(nullLong) == ''); 
        System.assert( StringHelper.toString(10L) == '10'); 
        System.assert( StringHelper.toString(nullDecimal) == ''); 
        System.assert( StringHelper.toString(10.0) == '10.0'); 

   
    }


}