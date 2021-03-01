public virtual with sharing class ProjectRepository {

    virtual
    public Project__c create(Project__c project) {
        insert project;
        return project;
    }

    virtual
    public List<Project__c> create(List<Project__c> projects) {
        insert projects;
        return projects;
    }

    virtual
    public List<Project__c> findbyCode(String code) {
        // return [
        //     SELECT ProjectName__c, LastSyncDate__c, Budget__c, EndDate__c, StartDate__c, Status__c 
        //     FROM Project__c
        //     WHERE Id__c = :code
        // ];

        return null;
    }

}