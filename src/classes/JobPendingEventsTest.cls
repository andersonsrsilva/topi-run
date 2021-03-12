@isTest
private class JobPendingEventsTest {
    @isTest
    static void testPendingEvents() {
        // Given
        EventQueueFixtureFactory.createEventConfigForEvent ('ORDER_SAP_OUTBOUND', 'OrderOutboundCommand');

        EventQueue event = new EventBuilder()
            .createOutboundEventFor('ORDER_SAP_OUTBOUND')
            .withReceiver('SALESFORCE')
            .withStatus(EventQueueStatusType.SCHEDULED.name())
            .withBusinessDocumentNumber ( '234213' )
            .withBusinessDocumentCorrelatedNumber ( '234213, 324425' )
            .withPayload( EventQueueFixtureFactory.getOrderInboundResultFromJson() )
            .buildAndPusblish();

        Test.setCreatedDate(event.getEventId(), Datetime.now().addDays(-1) );
      
        // When
        Test.startTest();

        // Then
        JobPendingEvents sched = new JobPendingEvents();

        sched.execute(null);

        List<Queue__c> events = [SELECT Id, Status__c, CreatedDate FROM Queue__c WHERE Status__c =   'QUEUED'];

        System.assertEquals(1 , events.size());

        Test.stopTest();

    }

    @isTest
    static void testScheduleJob() {

        Test.startTest();
        ScheduleHelper.jobCountForTest = 100;
        JobPendingEvents.start();

        List<AggregateResult> results = [ SELECT count(Id) total from CronTrigger Where CronJobDetail.Name like '%JobPendingEvents%' ];

        System.assertEquals(1, results.size() );
        System.assertEquals(12, (Integer) results.get(0).get('total') );

        JobPendingEvents.abort();

        results = [ SELECT count(Id) total from CronTrigger Where CronJobDetail.Name like '%JobPendingEvents%' ];

        System.assertEquals(1, results.size() );
        System.assertEquals(0, (Integer) results.get(0).get('total') );

        Test.stopTest();

    }

}