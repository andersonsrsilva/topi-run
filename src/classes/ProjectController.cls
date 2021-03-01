@RestResource(urlMapping = '/api/module/project')
global with sharing class ProjectController {

    @HttpPost
    global static Project__c create(AgileProject project) {
        ProjectTransformer transformer = new ProjectTransformer();
        
        ProjectRepository repository = new ProjectRepository();

        return repository.create(transformer.toProject(project));

    }

}