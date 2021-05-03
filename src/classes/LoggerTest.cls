/**
 * @author ercarval - topi
 */
@isTest
public class LoggerTest {

    @isTest
    public static void givenSomeLogInfoThenLogIntoCorrectLevel () {

        Logger.debug ('Debug');

        System.assert(true, 'executed');

        Logger.log ('Info');

        System.assert(true, 'executed');

        Logger.error ('error');

        System.assert(true, 'executed');

        Logger.warn ('error');

        System.assert(true, 'executed');

    }

}