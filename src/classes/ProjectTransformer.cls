public class ProjectTransformer {

    public Project__c toProject(AgileProject agileProject) {
        return new Project__c (
            ProjectName__c = agileProject.name,
            StartDate__c = agileProject.startDate,
            EndDate__c = agileProject.endDate,
            ExternalId__c = agileProject.externalId
        );
    }

}