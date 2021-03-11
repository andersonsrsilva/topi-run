import { LightningElement } from 'lwc';
 
export default class AccountBillingAddress extends LightningElement {

    billingAddress;

    constructor() {
        super();
        console.log('AccountBillingAddress Constructor');

        this.billingAddress = {
            street: 'Bisso',
            streetNumber: '848',
            additionaInfo: 'apto 101',
            zipCode: '240051-518',
            city: 'São José do Pinhais',
            state: 'PR'
        }
    }

    // connectedCallback() {
    //     console.log('EditAddress Connected Callback');
    // }

    // renderedCallback() {
    //     console.log('EditAddress Redered Callback');
    // }

    handleChangedAddress(event) {
        this.billingAddress = event.detail;
    }

}