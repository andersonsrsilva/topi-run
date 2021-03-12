/**
 * @author ercarval
 */
@isTest
private class RefreshOAuthAccessTokenTest {

    @isTest
    public static void givenOAuthConfigWhenScheduledThenAuthenticate () {

        EventQueueFixtureFactory.createOutboundEventConfigWithOAuthConfig ('OAUTH', 'MockCommandLogTrace', 'OAUTH');

        RefreshOAuthAccessToken.start();

        List<AggregateResult> results = [ SELECT count(Id) total from CronTrigger Where CronJobDetail.Name like '%RefreshOAuthAccessToken%' ];

        System.assertEquals(1, results.size() );
        System.assertEquals(1, (Integer) results.get(0).get('total') );

        RefreshOAuthAccessToken.abort();

        results = [ SELECT count(Id) total from CronTrigger Where CronJobDetail.Name like '%RefreshOAuthAccessToken%' ];

        System.assertEquals(1, results.size() );
        System.assertEquals(0, (Integer) results.get(0).get('total') );


        new RefreshOAuthAccessToken().execute(null);

    }

}