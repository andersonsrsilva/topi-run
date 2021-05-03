/**
 * @author ercarval - Topi
 */
@isTest
public class EventConsumerTest {

	@isTest
	public static void whenSendSeveralEventsSplitEvent() {

		EventQueueFixtureFactory.createBaseEvent ('SYNC_OUTBOUND');

		Test.startTest();

		//Test.setMock ( HttpCalloutMock.class , new OutboundProxyTest());

		List<Queue__c> events = new List<Queue__c>();
		for (Integer i = 0; i < 100 ; i++) {
			EventBuilder builder = new EventBuilder();
			events.add( builder.createOutboundEventFor( 'SYNC_OUTBOUND' )
			            .forObjectId( '3213213112321')
			            .withBusinessDocumentNumber ( 'XXXXXXXX' )
			            .withBusinessDocumentCorrelatedNumber( 'XXXXXX' )
			            .withInternalID ('XXXXXXXX')
			            .withPayload( 'XXXXXXXX' )
			            .withSender ('SALESFORCE')
			            .withReceiver ('RECEIVER')
			            .usingRetryStrategy()
			            .build());
		}

		insert events;		
		
		Test.stopTest();
		
		List<AggregateResult> results = [SELECT count(Id) total, Status__c from Queue__c Group by Status__c ];
		System.debug(JSON.serialize(results));

		System.assertEquals(1, results.size());
		System.assertEquals( 100 , (Integer) results.get(0).get('total') );
		System.assertEquals( 'UNHANDLED' , (String) results.get(0).get('Status__c') );
		
	}


}