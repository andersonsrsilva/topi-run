import { api, LightningElement } from 'lwc';
import searchAddress from '@salesforce/apex/SearchAddressCtrl.searchAddress';

export default class SearchZipcode extends LightningElement {

    @api
    zipCode;

    constructor() {
        super();
        console.log('SearchZipcode Constructor');
    }

     connectedCallback() {
        //console.log('EditAddress Connected Callback');
     }

    renderedCallback() {
        //console.log('EditAddress Redered Callback');
    }

    handleBlur(event) {

        if(!event.target.value || event.target.value == this.zipCode) return;

        let _zipCode = Object.assign(event.target.value.replace('-', ''));

        searchAddress({ zipCode : _zipCode })
        .then(response => {
            let address = response;
            this.publishAddressChanged(address);
        }).catch(response => {
            this.template.querySelector("[data-name='zipcode']")
            .setCustomValidity(response.body.message)
            .reportValidity();
        });

        console.log('final do blur');
        
    }

    publishAddressChanged(address) {
        let searchedAddress = new CustomEvent ('searchedaddress', {
            detail: address
        });

        this.dispatchEvent(searchedAddress);
    }

}