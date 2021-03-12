/**
 * @author ercarval - Topi
 */
public class NumberHelper {

    public static Decimal parseCurrencyToDecimal (String value) {

        if ( String.isEmpty(value) ) return 0.0;

        value = value.replaceAll('[^0-9,\\,\\.]', '').replace('.', '').replace(',', '.').trim();

        if (String.isEmpty(value)) return 0.0;

        return Decimal.valueOf( value.trim() );

    }

    public static Integer parseInt ( String value, Integer defaultValue ) {

        if (String.isEmpty(value) || !value.isNumeric() ) return defaultValue;

        return Integer.valueOf(value);
    }

    public static Integer parseInt ( String value ) {
        return parseInt (value, null);
    }

    public static Long parseLong ( String value, Long defaultValue ) {

        if (String.isEmpty(value) || !value.isNumeric() ) return defaultValue;

        return Long.valueOf(value);
    }

    public static Long parseLong ( String value ) {
        return parseLong (value, null);
    }

}