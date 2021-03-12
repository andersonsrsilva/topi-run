/**
 *
 * @author: ercarval
 */
@isTest
public with sharing class DateTimeHelperTest {


    @isTest
    private static void removeSecondsFromCurrentDate() {

        DateTime now = System.now();

        DateTime currentTimeWithMinousOneHundredSeconds = now.addSeconds( -1 * 100 ) ;

        System.debug(currentTimeWithMinousOneHundredSeconds);

        DateTime calculatedToTest = DateTimeHelper.removeSencondsIntoDate(now, 100);

        System.debug(calculatedToTest);
        System.assert( currentTimeWithMinousOneHundredSeconds == calculatedToTest);

    }


    @isTest
    private static void removeStringSecondsFromCurrentDate() {

        DateTime now = System.now();

        DateTime currentTimeWithMinousOneHundredSeconds = now.addSeconds( -1 * 100 ) ;

        System.debug(currentTimeWithMinousOneHundredSeconds);

        DateTime calculatedToTest = DateTimeHelper.removeSencondsIntoCurrentDate(100);

        System.assertEquals( currentTimeWithMinousOneHundredSeconds,  calculatedToTest);

    }

    @isTest
    private static void formatDate() {
        Date day = Date.newInstance(2017, 1, 1);

        System.assert(DateTimeHelper.format(day, 'dd/MM/yyyy') == '01/01/2017');
    }

    @isTest
    private static void givenTimeAsTextThenReturnTimeInstance() {
        System.assert( DateTimeHelper.getTimeFromText(null) == null);
        System.assert( DateTimeHelper.getTimeFromText('') == null);
        System.assert( DateTimeHelper.getTimeFromText('a') == null);
        System.assert( DateTimeHelper.getTimeFromText('2.99') == null);
        System.assert( DateTimeHelper.getTimeFromText('3') == null);
        System.assert( DateTimeHelper.getTimeFromText('42') == null);
        System.assert( DateTimeHelper.getTimeFromText('text') == null);
        System.assert( DateTimeHelper.getTimeFromText('14:30:00:00') == null);

        System.assert( DateTimeHelper.getTimeFromText('9:30') == Time.newInstance(9, 30, 0, 0));
        System.assert( DateTimeHelper.getTimeFromText('14:30') == Time.newInstance(14, 30, 0, 0));
        System.assert( DateTimeHelper.getTimeFromText('16:22') == Time.newInstance(16, 22, 0, 0));
        System.assert( DateTimeHelper.getTimeFromText('10:47:19') == Time.newInstance(10, 47, 19, 0));
        System.assert( DateTimeHelper.getTimeFromText('15:11:51') == Time.newInstance(15, 11, 51, 0));
    }

    @isTest
    public static void givenDateTimeAndPatternWhenFormatThenShowDateTimeStringWithPatternFormat () {

        String expectedDate = '2019-12-2015:15:15';

        Datetime dateTimeValue = Datetime.newInstance(2019, 12, 20, 15, 15, 15);

        String actualValue = DateTimeHelper.format (dateTimeValue, 'yyyy-MM-ddHH:mm:ss');

        System.assertEquals( expectedDate, actualValue );

    }

    @isTest
    public static void givenDateTimeAsJsonWhenParseThenShowDateTime() {

        String dateTimeAsJson = '2019-12-20T15:15:15';

        Datetime expectedDate = Datetime.newInstance(2019, 12, 20, 15, 15, 15);

        Datetime actualDate = DateTimeHelper.parseWithIsoFormat (dateTimeAsJson);

        System.assertEquals( expectedDate, actualDate );

    }

    @isTest
    public static void givenDateWhenGetDateTimeThenSetDateTimeToEndOfTheDay() {

        Datetime expectedDate = Datetime.newInstance(2019, 12, 20, 23, 59, 59);

        Datetime actualDateTime = DateTimeHelper.toDateTimeAtLastHour (Date.newInstance(2019, 12, 20) );

        System.assertEquals( expectedDate, actualDateTime );

    }

    @isTest
    public static void shouldAddDatetimeWithPatternInfoLog() {

        String nowAsLog = DateTimeHelper.getNowForLog();
        System.assert (nowAsLog != null);
    }


    @isTest
    public static void givenDateTimeWhenformatThenShowTimeStringOnly() {

        String extendedTime = '23:59';

        String actualTime = DateTimeHelper.getTimeAsString ( Datetime.newInstance(2019, 12, 20, 23, 59, 59) );

        System.assertEquals( extendedTime, actualTime );

    }


}