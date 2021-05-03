/**
 * @author ercarval - Topi
 */
@isTest
private class RestOutboundServiceTest {

    @isTest
    static void sendRequest() {

        EventQueueFixtureFactory.createOutboundEventConfigWithOAuthConfig('SYNC_OUT', 'CommandName', 'OAUTH'  );

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('SYNC_OUT');

        String expected = '{"response":"ok"}' ;

        Test.setMock( HttpCalloutMock.class , new HttpMock ( expected ));
        Test.startTest();

        RestOutboundServiceMock mock = new RestOutboundServiceMock(event);

        String response = mock.send('XXXX');

        System.assertEquals(expected, response);
        
        response = mock.get( new Map<String, String> {'param' => 'value'});
        
        System.assertEquals(expected, response);
        
        response = mock.get( '/url/mapping');
        
        System.assertEquals(expected, response);

        Test.stopTest();

    }

    public class RestOutboundServiceMock extends AbstractRestOutboundService {

        public RestOutboundServiceMock() {
        }

        public RestOutboundServiceMock(EventQueue event) {
            super ( event );
        }

        override
        public Object processResult( String response ) {
            return response;
        }

    }
}