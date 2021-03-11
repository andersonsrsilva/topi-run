import { api, LightningElement } from 'lwc';
 
export default class EditAddress extends LightningElement {

    @api
    address;

    constructor() {
        super();
        console.log('EditAddress Constructor');

        this.address = {
            street: 'Rua',
            streetNumber: '132',
            additionaInfo: 'apto 432',
            zipCode: '12222-000',
            city: 'São José',
            state: 'SP'
        }
    }

    connectedCallback() {
        console.log('EditAddress Connected Callback');
    }

    renderedCallback() {
        console.log('EditAddress Redered Callback');
    }

    handleSearchedAddress(event) {

        console.log(JSON.stringify(event.detail));
        
        this.address = event.detail;
    }

}