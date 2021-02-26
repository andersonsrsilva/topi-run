/*
* @author anderson.silva
*/

public class GetAddressOutbountService {

    public ViaCepAddressResponse findAddress(String zipCode) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://viacep.com.br/ws/' + zipCode + '/json/');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        Http http = new Http();
        HttpResponse response = http.send(request);

        String payload = response.getBody();

        System.debug(payload);

        return (ViaCepAddressResponse) JSON.deserialize(payload, ViaCepAddressResponse.class);
    }

}