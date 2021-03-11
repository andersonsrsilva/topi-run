public with sharing class SearchAddressCtrl {

    @AuraEnabled
    public static ZipCodeAddress searchAddress(String zipCode){
        
        GetAddressOutbountService service = new GetAddressOutbountService();

        return service.findAddress(zipCode);
    }

}