/**
 * @author: ercarval - topi
 */
public virtual class AccountRepository extends AbstractRepository {

    public Account findOne (String id) {

        return [SELECT Id, Name
                FROM Account WHERE Id = :id];

    }



}