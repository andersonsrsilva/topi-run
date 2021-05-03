public class TopiRunProjectRequest {

    public String name;
    public String code;
    public String status;
    public Date startDate;
    public Date endDate;
    public Decimal budget;

    public TopiRunProjectRequest() {
        this.budget = 1000000;
    }

    override
    public String toString() {
        return JSON.serialize(this);
    }

}