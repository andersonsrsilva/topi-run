/**
 *
 * @author: ercarval
 */
public with sharing class DateTimeHelper {

    public static final String NOW_LOG_PATTERN = 'dd-MM-yyyy HH:mm:ss.SSS';

    public static DateTime removeSencondsIntoCurrentDate( Integer seconds) {
        if ( seconds == null ) return null;
        return removeSencondsIntoDate(System.now() , seconds );
    }

    public static DateTime removeSencondsIntoDate(DateTime timestamp, Integer seconds ) {
        if ( seconds == null ) return null;
        return timestamp.addSeconds( -1 * seconds );
    }

    public static String formatDate (Date dateInfo, String pattern) {
        return format (dateInfo, pattern);
    }

    public static String format (Date dateInfo, String pattern) {
        Datetime dt = DateTime.newInstance(dateInfo.year(), dateInfo.month(), dateInfo.day());
        return dt.format(pattern);
    }

    public static String format( Datetime datetimeInfo, String pattern ) {

        if (datetimeInfo == null) return '';

        return datetimeInfo.format (pattern);
    }

    public static String getNowForLog () {
        return System.now().format(NOW_LOG_PATTERN);
    }

    /**
     * Use Json deserialize to Create Date Time Instance
     * @param  String value with Pattern yyyy-MM-dd'T'HH:mm:ss like 2017-09-14T15:42:29
     * @return Datetime instance
     */
    public static Datetime parseWithIsoFormat(String value) {

        if (value == null || value.trim() == '' || value.length() < 19 ) return null;

        Integer year = Integer.valueOf( value.substring(0, 4) );
        Integer month = Integer.valueOf(value.substring(5, 7) );
        Integer day = Integer.valueOf(value.substring(8, 10) );
        Integer hour = Integer.valueOf(value.substring(11, 13));
        Integer minute = Integer.valueOf(value.substring(14, 16));
        Integer second = Integer.valueOf(value.substring(17, 19));

        return Datetime.newInstance(year, month, day,  hour, minute,  second);

    }

    /**
     * Convert Date into DateTime instance using last hour 23:59:59
     * @param  dateValue [description]
     * @return           [description]
     */
    public static Datetime toDateTimeAtLastHour (Date dateValue) {
        if (dateValue == null) return null;
        Time lastHour = Time.newInstance(23, 59, 59, 0);
        return Datetime.newInstance( dateValue , lastHour);
    }

    public static Time getTimeFromText(String timeText) {

        if (timeText == null || timeText.indexOf(':') == -1) return null;

        String[] splitText = timeText.split(':');
        if (splitText.size() == 2) {
            return time.newInstance( Integer.valueOf(splitText[0]), Integer.valueOf(splitText[1]), 0, 0);
        } else if (splitText.size() == 3) {
            return time.newInstance( Integer.valueOf(splitText[0]), Integer.valueOf(splitText[1]), Integer.valueOf(splitText[2]), 0);
        }

        return null;
    }

    public static String getTimeAsString (Datetime dateValue) {
        if (dateValue == null ) return null;
        return dateValue.format('HH:mm');
    }


}