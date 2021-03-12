/**
 * Used to construct criteria queries, compound selections, expressions, predicates, orderings.
 * @author: ercarval - topi
 */
public virtual class Criteria {


    public String query;
    public String soql;


    public List<SObject> queryResult;

    public class SearchException extends Exception {}

    public Criteria() {
        soql = '';
    }

    public Criteria(String query) {
        this();
        this.query = query;
        queryResult = new List<SObject>();
    }


    public String toSoqlString () {
        System.debug(soql);
        return ( soql != null && soql != '' ) ? query + ' where ' + soql : query;
    }

    public Criteria add (Junction junction) {

        if (junction == null || junction.toString() == '') {
            return this;
        }

        if (this.soql != null && this.soql != '') {
            this.soql += Restriction.andd(junction.toString());
            return this;
        }

        this.soql += junction.toString();
        return this;
    }

    public Criteria add ( Criteria criteria , String expression ) {

        if (expression == null || expression == '') return this;

        if (criteria.soql != null && soql != '') {
            criteria.soql += Restriction.andd( expression );
        } else {
            criteria.soql +=  expression;
        }
        return this;
    }

    public Criteria add ( String expression ) {
        return add(this, expression );
    }

    public Criteria addOr ( Criteria criteria , String expression ) {

        if (expression == null || expression == '') return this;

        if (criteria.soql != null && soql != '') {
            criteria.soql += Restriction.orr( expression );
        } else {
            criteria.soql +=  expression;
        }

        return this;
    }

    public Criteria addOr ( String expression ) {
        return addOr (this, expression );
    }

    public Criteria limitedBy ( Integer expression ) {
        if (expression == null) return this;
        this.soql += Restriction.addLimit(expression);
        return this;
    }

    public Criteria startingBy ( Integer expression ) {
        if (expression == null) return this;
        this.soql += Restriction.addOffset(expression);
        return this;
    }

    public Criteria orderingBy ( String expression ) {
        if (expression == null || expression == '') return this;
        this.soql += Restriction.orderBy(  expression);
        return this;
    }

    virtual
    public List<SObject> search() {

        try {

            String queryStr = this.toSoqlString();

            System.debug ('\n\n\n [Criteria SQL] : \n\n ------------ \n' + queryStr);

            queryResult = Database.query(queryStr);

        } catch (System.QueryException e) {

            System.debug ('\n\n\n Exception : ' + e);

            throw e;
        }

        return queryResult;
    }

    virtual
    public SObject searchFirstResult() {

        List<SObject> results = search();

        if ( results.isEmpty()) throw new SearchException('List has no rows to assigment to instancce');

        return results.get(0);

    }

}