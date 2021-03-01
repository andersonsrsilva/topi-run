/*
* @author anderson.silva
*/

@isTest
public class GetAddressOutbountServiceTest {

    @isTest
    public static void givenZipCodeWhenCallViaCepServiceThenReturnValidZipCodeAddress () {

        String payload = '{ "cep": "01001-000", "logradouro": "Praça da Sé", "complemento": "lado ímpar", "bairro": "Sé", "localidade": "São Paulo", "uf": "SP", "ibge": "3550308", "gia": "1004", "ddd": "11", "siafi": "7107" }';
       

        Test.setMock(HttpCalloutMock.class, new ViaCepSuccessHttpMock(payload));

        Test.startTest();

        GetAddressOutbountService service = new GetAddressOutbountService();

        ZipCodeAddress response = service.findAddress('01001000');

        Test.stopTest();

        System.assertEquals('01001-000', response.zipCode);
        System.assertEquals('Praça da Sé', response.street);
        System.assertEquals('São Paulo', response.city);

    }

    @isTest
    public static void givenZipCodeWhenCallViaCepServiceThenFailToReturnThrowException() {

        String payload = '{ "code": "400", "message": "fail to return" }';
       
        Test.setMock(HttpCalloutMock.class, new ViaCepFailHttpMock(payload));

        Test.startTest();

        GetAddressOutbountService service = new GetAddressOutbountService();

        try {
            ZipCodeAddress response = service.findAddress('01001000');            

            System.assert(false, 'Exception expected');
        } catch (CalloutException e) {
            System.assert(true);
        }

        Test.stopTest();
    }

    public class ViaCepSuccessHttpMock implements HttpCalloutMock {

        String payload;

        public ViaCepSuccessHttpMock(String payload) {
            this.payload = payload;
        }

        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setBody(payload);
            response.setStatusCode(200);

            return response;
        }

    }

    public class ViaCepFailHttpMock implements HttpCalloutMock {

        String payload;

        public ViaCepFailHttpMock(String payload) {
            this.payload = payload;
        }

        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setBody(payload);
            response.setStatusCode(400);

            return response;
        }

    }

}