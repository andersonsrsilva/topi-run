/*
* @author anderson.silva
*/

@isTest
public class ProjectFixtureFactory {

    public static Project__c newProject() {
        return newProject(
            'TopiRun2020', 
            '01932190123', 
            'Não inicializado', 
            Date.newInstance(2020, 1, 1),
            Date.newInstance(2020, 12, 1),
            200000.00);
    }

    public static Project__c newProject(String name, String code, String status, Date startDate, Date endDate, Decimal budget) {
        return new Project__c(
            ProjectName__c = name, 
            Id__c = code,
            Status__c = status,
            StartDate__c = startDate,
            EndDate__c = endDate, 
            Budget__c = budget
        );
    }

    public static Project__c createProject(String name, String code, String status, Date startDate, Date endDate, Decimal budget) {
        return createProject(newProject(name, code, status, startDate, endDate, budget));
    }

    public static Project__c createProject() {
        return createProject(newProject());
    }

    public static Project__c createProject(Project__c project) {
        insert project;
        return project;
    }

}