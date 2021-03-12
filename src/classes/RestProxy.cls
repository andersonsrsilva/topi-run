/**
 * Decorete Response  with event.addPayload();
 * @author ercarval
 */
public virtual class RestProxy extends BaseRestProxy {

    protected EventQueue event;

    public RestProxy() {
        super();
    }

    public RestProxy(EventConfiguration__c config) {
        super(config);
    }

    public RestProxy(EventQueue event) {
        this(event.config);
        this.event = event;
    }

    virtual
    override
    public void setBody (Object obj) {
        super.setBody(obj);
        this.event.addPayload ( 'REQUEST_PAYLOAD_' + System.now() ,  JSON.serialize(obj) );
    }

    override
    public void postSend() {
        super.postSend();
        this.event.addPayload ( 'RESPONSE_PAYLOAD_' + System.now() ,  httpResponse.getBody() );
    }
}