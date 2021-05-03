/**
 * @author Vinicius Ferraz - TOPi
 */
@isTest
public class HttpMock implements HttpCalloutMock {

    String reponse;
    Boolean isSucess;

    public HttpMock (String reponse) {
        this.reponse = reponse;
        this.isSucess = true;
    }

    public HttpMock (String reponse, Boolean success) {
        this.reponse = reponse;
        this.isSucess = success;
    }

    public HTTPResponse respond(HTTPRequest request) {
        return (this.isSucess ? buildSuccessResponse(reponse) : buildFailedResponse(reponse));
    }

    public HTTPResponse buildSuccessResponse  (String reponse) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody( reponse );
        res.setStatusCode(200);
        return res;
    }

    public HTTPResponse buildFailedResponse  (String reponse) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody( reponse );
        res.setStatusCode(400);
        return res;
    }

}