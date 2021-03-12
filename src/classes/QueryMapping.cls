/**
 *
 * @author Eduardo R Carvalho
 */
virtual
public class QueryMapping {

    public String fieldName {get; set;}
    public String value     {get; set;}

    public QueryMapping () {} //NOPMD

    public QueryMapping (String fieldName , String value) {
        this.fieldName = fieldName;
        this.value = value;
    }

    public QueryMapping ( String fieldName ) {
        this.fieldName = fieldName;
        this.value = '';
    }

    virtual
    public String getValue () {
        return value;
    }


    public Boolean getValueAsBoolean () {
        return value == null ? null : Boolean.valueOf(value);
    }
}