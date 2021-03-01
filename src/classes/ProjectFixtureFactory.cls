/*
* @author anderson.silva
*/

@isTest
public class ProjectFixtureFactory {

    public static Project__c newProject() {
        return null;

        // return newProject(
        //     '01932190123', 
        //     'Não inicializado', 
        //     Date.newInstance(2020, 1, 1),
        //     Date.newInstance(2020, 12, 1),
        //     200000.00);
    }

    public static Project__c newProject(String code, String status, Date startDate, Date endDate, Decimal budget) {
        return new Project__c();
    }

    public static Project__c createProject(String code, String status, Date startDate, Date endDate, Decimal budget) {
        return createProject(newProject(code, status, startDate, endDate, budget));
    }

    public static Project__c createProject() {
        return createProject(newProject());
    }

    public static Project__c createProject(Project__c project) {
        insert project;
        return project;
    }

}