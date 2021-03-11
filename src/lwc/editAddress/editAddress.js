import { api, LightningElement } from 'lwc';
 
export default class EditAddress extends LightningElement {

    @api
    address;

    set localAddress(address) {
        console.log('address changed');
        this._address = Object.assign(address);
        this.dispacthChangeAddress();
    }
    
    get localAddress() {
        return this._address;
    }

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
        //console.log('EditAddress Connected Callback');
        this.localAddress = this.address;
    }

    renderedCallback() {
        //console.log('EditAddress Redered Callback');
    }

    handleSearchedAddress(event) {
        console.log(JSON.stringify(event.detail));
        this.address = event.detail;
        this.localAddress = event.detail;
    }

    dispacthChangeAddress() {
        let changedAddress = new CustomEvent('addresschanged', {
            detail : this.localAddress
        });

        this.dispatchEvent(changedAddress);
    }

    handleChange(event) {
        let _address = JSON.parse(JSON.stringify(this.localAddress));
        _address[event.target.name] = event.target.value;

        this.localAddress = _address;
    }

}