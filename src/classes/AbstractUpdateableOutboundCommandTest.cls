/**
 * @author ercarval - topi
 */
@isTest
public class AbstractUpdateableOutboundCommandTest {

    /**
     * @Before like
     */
    @testSetup
    public static void setup() {
        EventQueueFixtureFactory.createEventConfigForUnhandledEvent();
    }

    @isTest
    public static void givenOutboundEventThenGenericOutboundCommandTransformAndSendRequest () {

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('SYNC_OUTBOUND');

        AbstractUpdateableOutboundCommandMock outboundMock = new AbstractUpdateableOutboundCommandMock();

        outboundMock.execute(event);
        outboundMock.postUpdateExecute(event);

        System.assert( outboundMock.targetObject instanceOf Contact );
        System.assertEquals( outboundMock.targetObject , outboundMock.mockedContact );
        System.assert( outboundMock.postResultExecuted );

    }


    public class AbstractUpdateableOutboundCommandMock extends AbstractUpdateableOutboundCommand {

        public Contact mockedContact = new Contact (email = 'Bisso');

        @TestVisible
        private String toBeTransformed = '{"attributes":{"type":"Contact"},"Email":"Bisso"}';

        public Contact mockResponse;

        public boolean postResultExecuted;

        public AbstractUpdateableOutboundCommandMock () {
            super();
            postResultExecuted = false;
        }

        override
        public Object send() {
            return mockedContact;
        }

        override
        public Object transformToSend () {
            return JSON.deserialize( toBeTransformed , Contact.class );
        }

        override
        public void processResult (Object responseObject) {
        }

        override
        public void postUpdateExecute() {
            postResultExecuted = true;
        }

    }    
    


}