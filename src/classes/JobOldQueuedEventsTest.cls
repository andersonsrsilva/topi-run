@isTest
private class JobOldQueuedEventsTest {

    @isTest
    static void testPendingEvents() {
        // Given
        EventQueueFixtureFactory.createEventConfigForEvent ('MOCK_LOG', 'MockCommandLogTrace');

        TriggerHandler.byPass ('EventQueueTH');
        
        EventQueue event = new EventBuilder()
            .createOutboundEventFor('MOCK_LOG')
            .withReceiver('SALESFORCE')
            .withInternalId( '32233443423432' )
            .withBusinessDocumentNumber ( '234213' )
            .withBusinessDocumentCorrelatedNumber ( '234213, 324425' )
            .withPayload( EventQueueFixtureFactory.getOrderInboundResultFromJson() )
            .buildAndSave();

        Test.setCreatedDate(event.getEventId(), Datetime.now().addDays(-1) );
        
        Test.startTest();

        TriggerHandler.clearAllBypasses();

        JobOldQueuedEvents schedule = new JobOldQueuedEvents();

        schedule.execute(null);

        List<Queue__c> events = [SELECT Id, Status__c, CreatedDate FROM Queue__c WHERE Status__c =   'QUEUED'];

        System.assert(events.size() == 1);

        Test.stopTest();

    }

    @isTest
    static void testScheduleJob() {

        Test.startTest();
        ScheduleHelper.jobCountForTest = 210;
        JobOldQueuedEvents.start();

        List<AggregateResult> results = [ SELECT count(Id) total from CronTrigger Where CronJobDetail.Name like '%JobOldQueuedEvents%' ];

        System.assertEquals(1, results.size() );
        System.assertEquals(7, (Integer) results.get(0).get('total') );

        JobOldQueuedEvents.abort();

        results = [ SELECT count(Id) total from CronTrigger Where CronJobDetail.Name like '%JobOldQueuedEvents%' ];

        System.assertEquals(1, results.size() );
        System.assertEquals(0, (Integer) results.get(0).get('total') );

        Test.stopTest();

    }


}