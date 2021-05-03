/**
 *
 * @author Marcelo Gomes - TOPi
 */
@isTest
public class Random {

    class RandomException extends Exception {}

    public static Integer generateInteger(Integer length) {

        return Integer.valueOf(generateString(length, CharacterSet.NUMERIC));
    }

    public static Decimal generateDecimal(Integer length, Integer decimalPlaces) {

        if ((decimalPlaces == null) || (decimalPlaces < 0)) {

            decimalPlaces = 0;
        }

        if (decimalPlaces >= length) {

            throw new RandomException('Parameter "decimalPlaces" must be smaller than parameter "length".');
        }

        String decimalPlacesValue = (decimalPlaces == 0) ? '0' : generateString(decimalPlaces, CharacterSet.NUMERIC);
        String integerValue = generateString(length - decimalPlaces, CharacterSet.NUMERIC);

        return Decimal.valueOf(integerValue + '.' + decimalPlacesValue);
    }

    public static String generateString(Integer length, CharacterSet charSet) {

        if ((length == null) || (length < 1)) {

            throw new RandomException('Parameter "length" must be greater than zero.');
        }

        String chars = getCharacters(charSet);
        String[] result = new String[length];
        Integer index = 0;

        while (index < length) {

            Integer chr = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            result[index++] = chars.substring(chr, chr + 1);
        }

        return String.join(result, '');
    }

    private static String getCharacters(CharacterSet charSet) {

        if (charSet == CharacterSet.NUMERIC) {

            return '0123456789';
        } else if (charSet == CharacterSet.LOWER_ALPHA) {

            return 'abcdefghijklmnopqrstuvwxyz';
        } else if (charSet == CharacterSet.UPPER_ALPHA) {

            return 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        } else if (charSet == CharacterSet.ALPHA) {

            return 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
        } else if (charSet == CharacterSet.LOWER_ALPHA_NUMERIC) {

            return '0123456789abcdefghijklmnopqrstuvwxyz';
        } else if (charSet == CharacterSet.UPPER_ALPHA_NUMERIC) {

            return 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        } else if (charSet == CharacterSet.ALPHA_NUMERIC) {

            return 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        } else {

            throw new RandomException('Argument out of range valid for enum CharacterSet');
        }
    }
}