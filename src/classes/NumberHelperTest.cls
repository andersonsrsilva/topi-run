/**
 * @author ercarval - Topi
 */
@isTest
public class NumberHelperTest {

    @isTest
    public static void givenCurrencyValueWhenConvertThenReturnDecimalValue () {
        
        System.assert( NumberHelper.parseCurrencyToDecimal( ' R$   110,00 ' ) == 110.00 );
        System.assert( NumberHelper.parseCurrencyToDecimal( 'R$ 110,00' ) == 110.00 );
        System.assert( NumberHelper.parseCurrencyToDecimal( 'R$100,00' ) == 100.00 );
        System.assert( NumberHelper.parseCurrencyToDecimal( 'R$0,00' ) == 0.0 );
        System.assert( NumberHelper.parseCurrencyToDecimal( '' ) == 0.0 );
        System.assert( NumberHelper.parseCurrencyToDecimal( 'R$ 100,99' ) == 100.99 );
        System.assert( NumberHelper.parseCurrencyToDecimal( 'R$ 1.000,99' ) == 1000.99 );
        
    }
    
    @isTest
    public static void givenStringValueWhenConvertThenReturnIntegerValue () {

        System.assert( NumberHelper.parseInt('A') == null ); 
        System.assert( NumberHelper.parseInt('') == null ); 
        System.assert( NumberHelper.parseInt(null) == null ); 
        System.assert( NumberHelper.parseInt('0') == 0 ); 
        System.assert( NumberHelper.parseInt('10') == 10 ); 
    
        System.assert( NumberHelper.parseInt(null, 0) == 0 ); 
        System.assert( NumberHelper.parseInt('A', 0) == 0 ); 
        System.assert( NumberHelper.parseInt('0', 0) == 0 ); 
        System.assert( NumberHelper.parseInt('10', 0) == 10 ); 

    }


    @isTest
    public static void givenStringValueWhenConvertThenReturnLongValue () {

        System.assert( NumberHelper.parseLong('A') == null ); 
        System.assert( NumberHelper.parseLong('') == null ); 
        System.assert( NumberHelper.parseLong(null) == null ); 
        System.assert( NumberHelper.parseLong('0') == 0 ); 
        System.assert( NumberHelper.parseLong('10') == 10 ); 
    
        System.assert( NumberHelper.parseLong(null, 0) == 0 ); 
        System.assert( NumberHelper.parseLong('A', 0) == 0 ); 
        System.assert( NumberHelper.parseLong('0', 0) == 0 ); 
        System.assert( NumberHelper.parseLong('10', 0) == 10 ); 

    }

}