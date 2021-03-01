public class ZipCodeAddress {

    public String city;
    public String street;
    public String state;
    public String streetNumber;
    public String zipCode;

    override
    public string toString() {
        return JSON.serialize(this);
    }

}