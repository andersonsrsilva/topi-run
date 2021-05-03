@isTest
public class EventBuilderTest {

    @isTest
    public static void buildEvent() {

        EventBuilder builder = new EventBuilder();

        Queue__c expected = new Queue__c (EventName__c = 'SYNC_BACKORDER_OUTBOUND'
            , ObjectId__c = '3213213112321'
            , businessDocument__c = 'XXXXXXXX'
            , businessDocumentCorrelatedNumber__c = 'XXXXXX'
            , Status__c = 'QUEUED'
            , internalId__c = 'XXXXXXXX'
            , Payload__c = 'XXXXXXXX'
            , Sender__c = 'SALESFORCE'
            , Receiver__c = 'EXTERNAL_SYSTEM'
            , retryCount__c = 0
            , IsRetryDisabled__c = true
        );
        
        Queue__c queue = builder.createOutboundEventFor( 'SYNC_BACKORDER_OUTBOUND' )
            .forObjectId( '3213213112321')
            .withBusinessDocumentNumber ( 'XXXXXXXX' )
            .withBusinessDocumentCorrelatedNumber( 'XXXXXX' )
            .withInternalID ('XXXXXXXX')
            .withPayload( 'XXXXXXXX' )
            .withSender ('SALESFORCE')
            .withReceiver ('EXTERNAL_SYSTEM')
            .usingRetryStrategy()
            .disablingRetryStrategy ()
            .build();

        System.assertEquals ( expected , queue );

    }


    @isTest
    public static void buildEventWithSameIdentifiers() {

        EventBuilder builder = new EventBuilder();

        Queue__c expected = new Queue__c (EventName__c = 'SYNC_BACKORDER_OUTBOUND'
            , ObjectId__c = 'XXXXXXXX'
            , BusinessDocument__c = 'XXXXXXXX'
            , BusinessDocumentCorrelatedNumber__c = 'XXXXXXXX'
            , InternalId__c = 'XXXXXXXX'
            , Payload__c = 'XXXXXXXX'
            , Sender__c = 'SALESFORCE'
            , Receiver__c = 'EXTERNAL_SYSTEM'
            , RetryCount__c = 10
            , IsRetryDisabled__c = false
            , Status__c = 'SUCCESS'
            , StatusMessage__c = 'HELLO'
        );
    
        Queue__c queue = builder.createOutboundEventFor( 'SYNC_BACKORDER_OUTBOUND' )
                              .withSameDocumentNumberForAllIdentifiers ( 'XXXXXXXX' )
                              .withPayload( 'XXXXXXXX' )
                              .withSender ('SALESFORCE')
                              .withReceiver ('EXTERNAL_SYSTEM')
                              .withStatus ('SUCCESS')
                              .withStatusMessage ('HELLO')
                              .withRetryCount(10)
                              .build();
                              
        System.assertEquals ( expected , queue );
        
        EventQueue eventQueue = builder.buildEvent();
        // event queue clean payload
        expected.Payload__c = '';

        System.assertEquals ( expected , eventQueue.get() );
    
    }

    @isTest
    public static void givenEventQueueWhenPublishThenCreateQueuedEvent () {

        EventQueue event = new EventBuilder().createOutboundEventFor( 'SYNC_BACKORDER_OUTBOUND' )
                .withSameDocumentNumberForAllIdentifiers ( 'XXXXXXXX' )
                .withSender ('SALESFORCE')
                .withReceiver ('EXTERNAL_SYSTEM')
                .usingRetryStrategy()
                .buildAndPusblish();
        
        System.assert( event.getEventId() != null );

    }

}