/**
 * @author: Eduardo Ribeiro de Carvalho - ercarval
 */
@isTest
public class RefreshOAuthOutboundCommandTest {

    @isTest
    public static void givenValidClientKeyAndSecretWhenGetTokenThenReceiceValidToken () {        
        
        OAuthConfiguration__c oauthConfig = EventQueueFixtureFactory.createOAuthConfig ('OAUTH', 'REFRESHTOKEN', 'ORDER');
        
        EventQueueFixtureFactory.createEventConfigForEvent ('OAUTH', 'RefreshOAuthOutboundCommand' );

        EventQueue event = new EventBuilder()
                         .createEventFor('OAUTH')
                         .withSameDocumentNumberForAllIdentifiers ('oauth.scope')
                         .withPayload( JSON.serialize (oauthConfig) )
                         .withStatus ('INVALID')
                         .buildAndSave();
        
        Test.startTest();

        String expected = new AccessToken ('132131223123').toString();

        Test.setMock( HttpCalloutMock.class , new HttpMock ( expected ) );

        RefreshOAuthOutboundCommand command = new RefreshOAuthOutboundCommand();
        command.execute (event);
        command.postUpdateExecute (event);

        OAuthConfiguration__c config = OAuthConfiguration__c.getAll().get('OAUTH');

        System.assertEquals('132131223123', config.token__c);
        
        Test.stopTest();
    }

}