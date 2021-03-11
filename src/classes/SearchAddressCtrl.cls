public class SearchAddressCtrl {

    @AuraEnabled(cacheable=true)
    public static ZipCodeAddress searchAddress(String zipCode){
        
        GetAddressOutbountService service = new GetAddressOutbountService();

        try {
            return service.findAddress(zipCode);    
        } catch (Exception e) {
            throw new AuraException();
        }
        
    }

}