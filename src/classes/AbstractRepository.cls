/**
 * Provide Base Repository Implementations
 * @author ercarval - topi
 */
public abstract class AbstractRepository {

    virtual
    public SObject save (SObject aggregate) {

        if (aggregate == null) return null;

        if (aggregate.Id == null ) {
            insert aggregate;
        } else {
            update aggregate;
        }

        return aggregate;
    }

    virtual
    public List<SObject> save (List<SObject> aggregates) {

        if (aggregates == null) return new List<SObject>();

        if (aggregates.isEmpty()) return aggregates;

        List<SObject> aggregatesToCreate = filterWithOutId (aggregates);

        if (!aggregatesToCreate.isEmpty()) {
            insert aggregatesToCreate;
        }

        List<SObject> aggregatesToUpdate = filterWithId (aggregates);

        if (!aggregatesToUpdate.isEmpty()) {
            update aggregatesToUpdate;
        }

        return aggregates;

    }

    virtual
    protected List<SObject> filterWithId (List<SObject> aggregates) {

        List<SObject> aggregatesToStore = new  List<SObject>();

        for (SObject aggregate : aggregates) {
            if (aggregate.id != null) aggregatesToStore.add (aggregate);
        }

        return aggregatesToStore;
    }

    virtual
    protected List<SObject> filterWithOutId (List<SObject> aggregates) {
        List<SObject> aggregatesToStore = new  List<SObject>();

        for (SObject aggregate : aggregates) {
            if (aggregate.id == null) aggregatesToStore.add (aggregate);
        }

        return aggregatesToStore;
    }

    virtual
    public List<Database.SaveResult> updateAll ( List<SObject> aggregates ) {

        if (aggregates == null || aggregates.isEmpty()) return new List<Database.SaveResult>();

        return Database.update (aggregates, false);
    }

    virtual
    public List<Database.SaveResult> insertAll ( List<SObject> aggregates ) {

        if (aggregates == null || aggregates.isEmpty()) return new List<Database.SaveResult>();

        return Database.insert (aggregates, false);
    }

    virtual
    public List<SObject> saveRelated ( SObject masterRecord
            , String lookupFieldName
            , List<SObject> aggregates ) {
        
        for (SObject aggregate: aggregates) {
            aggregate.put (lookupFieldName, masterRecord.Id);
        }

        return save(aggregates);
    }  

    virtual
    public void remove ( SObject record ) {
        if (record == null) return;
        delete record;
    }

    virtual
    public void remove ( List<SObject> records ) {
        if (records == null || records.isEmpty()) return;
        delete records;
    }

    virtual 
    public  List<SObject> save ( List<SObject> aggregates, Schema.SObjectField field){

        if (aggregates == null) return new List<SObject>();

        if (aggregates.isEmpty()) return aggregates;

        Database.upsert(aggregates, field);

        return aggregates;
    }

    virtual 
    public  SObject save ( SObject aggregate, Schema.SObjectField field){

        if (aggregate == null) return null;

        Database.upsert(aggregate, field);

        return aggregate;
    }

    @SuppressWarnings ('PMD.ExcessiveParameterList')
    virtual
    public List<SObject> saveRelated ( SObject masterRecord
            , String lookupFieldName
            , List<SObject> aggregates 
            , Schema.SObjectField field) {
        
        for (SObject aggregate: aggregates) {

            String idRelated = String.valueOf(aggregate.get('Id'));

            if(idRelated != '' && idRelated != null) continue;

            aggregate.put (lookupFieldName, masterRecord.Id);
        }

        Database.upsert(aggregates, field);

        return aggregates;
    }     

}