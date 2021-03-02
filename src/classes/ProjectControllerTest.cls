
@isTest
public with sharing class ProjectControllerTest {

    @isTest
    public static void givenValidProjectInfoWhenCallServiceThenCreateNewProject() {

        Test.startTest();

        AgileProject agileProject = new AgileProject();
        agileProject.externalId = '123123123123123';
        agileProject.name = 'Bisso Project';
        agileProject.startDate = Date.today();
        agileProject.endDate = Date.today().addDays(10);

        Project__c createProject = ProjectController.create(agileProject);

        Test.stopTest();

        System.assert(createProject != null);
        System.assert(createProject.Id != null);
        System.assertEquals(agileProject.externalId, createProject.externalId__c);

    }

    @isTest
    public static void givenValidProjectInfoWhenCallServiceThenReturnError() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        Test.startTest();

        ProjectController.getProjects();

        Test.stopTest();

        Integer responseCode = RestContext.response.statuscode;
        String responsePayload = String.valueOf(RestContext.response.responseBody);

        System.assertEquals(400, responseCode);
        
    }

    @isTest
    public static void givenValidProjectInfoWhenCallServiceThenReturnSuccessProjectInfo() {

        Project__c project = ProjectFixtureFactory.createProject('Test', Date.today(), Date.today().addDays(10));

        RestContext.request = new RestRequest();
        RestContext.request.addParameter('id', '' + project.Id);

        RestContext.response = new RestResponse();

        Test.startTest();

        ProjectController.getProjects();

        Test.stopTest();

        Integer responseCode = RestContext.response.statuscode;
        String responsePayload = RestContext.response.responseBody.toString();

        Project__c retrivedProject = (Project__c)JSON.deserialize(responsePayload, Project__c.class);

        System.assertEquals(200, responseCode);
        System.assertEquals(project.Id, retrivedProject.Id);
        
    }

}