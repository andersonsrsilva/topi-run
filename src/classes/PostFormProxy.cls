/**
 * @author ercarval - topi
 */
public virtual class PostFormProxy extends RestProxy {

    private static final String FORM_CONTENT_TYPE = 'application/x-www-form-urlencoded';

    public PostFormProxy() {
        super();
    }

    public PostFormProxy(EventQueue event) {
        this(event.config);
        this.event = event;
    }

    public PostFormProxy(EventConfiguration__c config) {
        super(config);
    }

    /**
     * rewrite Content-Type to application/x-www-form-urlencoded
     */
    override
    protected void setup() {
        super.setup();
        this.httpRequest.setHeader('Content-Type', FORM_CONTENT_TYPE);
        this.httpRequest.setHeader('Accept', 'application/json');
    }

    override
    public void setBody (Object requestParameters) {

        String requestQuery = buildQueryParameters ( deserializeToForm (requestParameters) );

        this.event.addPayload ( 'REQUEST_PAYLOAD_' + System.now() , requestQuery );

        this.httpRequest.setBody ( requestQuery );
    }

    private Map<String,String> deserializeToForm (Object obj) {
        
        Map<String,Object> deserializedParameter = (Map<String, Object>) JSON.deserializeUntyped( JSON.serialize (obj) );
        
        Map<String,String> parameters = new Map<String,String>();
        
        for ( String parameterName :  deserializedParameter.keySet()) {

            parameters.put ( parameterName , (String) + deserializedParameter.get( parameterName ) );

        }

        return parameters;

    }

}