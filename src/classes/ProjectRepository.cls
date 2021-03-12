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
    public Project__c findById(String id) {
        List<Project__c> projects = findByIds(new List<String>{ id });

        return !projects.isEmpty() ? projects.get(0) : null;
    }

    virtual
    public List<Project__c> findByIds(List<String> ids) {
        return [
            SELECT Id, EndDate__c, StartDate__c, ProjectName__c
            FROM Project__c
            WHERE Id in :ids
        ];
    }

    virtual
    public Project__c save(Project__c project) {
        if(project.Id == null) {
            return create(project);
        }else {
            return store(project);
        }
    }

    public Project__c store(Project__c project) {
        update project;
        return project;
    }

}