import { api, LightningElement } from 'lwc';
 
export default class SearchZipcode extends LightningElement {

    @api
    zipCode;

    constructor() {
        super();
        console.log('SearchZipcode Constructor');
    }

    connectedCallback() {
        console.log('EditAddress Connected Callback');
    }

    renderedCallback() {
        console.log('EditAddress Redered Callback');
    }

    handleBlur(event) {

        if(!event.target.value) return;

        this.publishAddressChanged();

    }

    publishAddressChanged() {
        let searchedAddress = new CustomEvent ('searchedaddress', {
            detail: {
                street: 'Rua TopiRun',
                streetNumber: '2020',
                additionaInfo: 'Turma 1',
                zipCode: '72880-000',
                city: 'Cidade Ocidental',
                state: 'GO'
            }
        });

        this.dispatchEvent(searchedAddress);
    }

}