public class GetAddressOutboundCommand extends AbstractUpdateableOutboundCommand {

    AccountRepository repository;
    ViaCepAddressResponse zipAddress;

    public GetAddressOutboundCommand() {
        repository = new AccountRepository();
    }

    override
    public Object transformToSend () {
        return event.getBusinessDocumentNumber();
    }

    override
    public Object send () {
        return proxy.send(targetObject + '/json');
    }

    override
    public void processResult (Object responseObject) {
        zipAddress = (ViaCepAddressResponse) JSON.deserialize(responseObject, ViaCepAddressResponse.class);
    }

    override
    public void postUpdateExecute() {
        repository.save(zipAddress.toAccount(event.getObjectId()));
    }

}