public class ProjectRepository {

    public List<Project__c> findbyCode(String code) {
        return [
            SELECT ProjectName__c, LastSyncDate__c, Budget__c, EndDate__c, StartDate__c, Id__c, Status__c 
            FROM Project__c
            WHERE Id__c = :code
        ];
    }

}