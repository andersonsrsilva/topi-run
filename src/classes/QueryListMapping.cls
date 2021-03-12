/**
 * VO para lista
 * @author : Eduardo R Carvalho
 */
public class QueryListMapping extends QueryMapping {

    private List<String> values;

    public QueryListMapping(String field) {
        super(field);
    }

    public QueryListMapping(String field, List<String> values) {
        this(field);
        setValues(values);
    }

    public List<String> getValues() {
        return values;
    }

    public void setValues (List<String> values) {
        this.values = values;
    }

}