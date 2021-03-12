public with sharing class TopiRunProjectTransformer {

    public TopiRunProjectRequest toTopiRunProject(Project__c project) {

        TopiRunProjectRequest request = new TopiRunProjectRequest();
        request.name = project.ProjectName__c;
        request.code = project.Id;
        request.status = project.Status__c;
        request.startDate = project.StartDate__c;
        request.endDate = project.EndDate__c;
        request.budget = project.Budget__c;
        return request;

    }

    public Project__c toProject(Project__c project, TopiRunProjectResponse response) {

        project.LastSyncDate__c = System.now();
        project.SynchronizationStatus__c = 'Integrado com sucesso';

        return project;

    }

    public Project__c toProject(Project__c project, TopiRunErrorResponse response) {

        project.LastSyncDate__c = System.now();
        project.SynchronizationStatus__c = 'Erro na sincronização dos projectos';
        project.ErrorMessage__c = response.errorMessage;

        return project;

    }

}

