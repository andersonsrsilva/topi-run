/**
 * @author: Eduardo - @ercarval
 */
public class QueryJsonListMapping extends QueryMapping {
    
    public QueryJsonListMapping(String field) {
        super(field);
    }

    public QueryJsonListMapping(String field, String payload) {
        this(field);
        this.value = payload;
    }

    public List<String> getValues() {
        if (String.isEmpty(this.value))  return null;
        return (List<String>) JSON.deserialize(value, List<String>.class );
    }
}