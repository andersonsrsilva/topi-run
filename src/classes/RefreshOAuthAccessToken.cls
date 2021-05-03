/**
 * @see Event
 * @author ercarval - topi
 */
public virtual class RefreshOAuthAccessToken implements Schedulable {


    public RefreshOAuthAccessToken() {

    }

    public void execute(SchedulableContext ctx) {

        execute();

        abortJob();

        reScheduleJob();

    }

    public void execute () {

        List<EventQueue> events = new List<EventQueue>();

        for (OAuthIntegrationBusConfiguration oauth : OAuthIntegrationBusConfiguration.getAllConfigurations() ) {

            if (!oauth.enabled) continue;

            events.add ( new EventBuilder()
                         .createEventFor(oauth.eventName)
                         .withSender('SALESFORCE')
                         .withReceiver('AUTHENTICATOR')
                         .withSameDocumentNumberForAllIdentifiers (oauth.scope)
                         .withPayload( JSON.serialize (oauth) )
                         .buildEvent() );

        }

        new EventQueue().createAllEvents (events);
    }


    public static void start() {
        new RefreshOAuthAccessToken().reScheduleJob();
    }

    public static void abort() {
        new RefreshOAuthAccessToken().abortJob();
    }

    public void reScheduleJob() {
        new ScheduleHelper().scheduleIntoNextMinutes(new RefreshOAuthAccessToken(), 25);
    }

    public void abortJob() {
        new ScheduleHelper().abort('RefreshOAuthAccessToken');
    }

}