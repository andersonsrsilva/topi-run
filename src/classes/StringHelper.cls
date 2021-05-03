/**
 * @author ercarval - Topi
 */
public class StringHelper {

    public static String nullToEmpty(String value) {
        return (value == null) ? '' : value.trim();
    }

    public static String useFirstOrSecond ( String firstValue, String secondValue) {
        return !String.isEmpty(firstValue) ? firstValue.trim() : secondValue;
    }

    public static Decimal useFirstOrSecond ( Decimal firstValue, Decimal secondValue) {
        return ( firstValue != null ) ? firstValue : secondValue;
    }

    public static boolean isEmptyOr(String value, String otherValue) {
        return String.isEmpty (value) || value == otherValue;
    }

    public static String toString ( Integer value ) {
        return (value != null) ? String.valueOf (value) : '';
    }

    public static String toString ( Long value ) {
        return (value != null) ? String.valueOf (value) : '';
    }

    public static String toString ( Decimal value ) {
        return (value != null) ? String.valueOf (value) : '';
    }

}