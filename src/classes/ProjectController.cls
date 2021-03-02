@RestResource(urlMapping = '/api/project')
global with sharing class ProjectController {

    @HttpPost
    global static Project__c create(AgileProject project) {
        ProjectTransformer transformer = new ProjectTransformer();
        
        ProjectRepository repository = new ProjectRepository();

        return repository.create(transformer.toProject(project));

    }

    @HttpGet
    global static void getProjects() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        Map<String, String> parameters = request.params;

        String projectId = parameters.get('id');

        if(String.isEmpty(projectId)) {
            response.statusCode = 400;
            response.responseBody = Blob.valueOf(new ProjectBusinessError('400', 'Invalid Project Id').toString());
            return;
        }

        ProjectRepository repository = new ProjectRepository();


        response.statusCode = 200;
        response.responseBody = Blob.valueOf(JSON.serialize(repository.findById(projectId)));
    }

    public class ProjectException extends Exception {}    

    public class ProjectBusinessError {

        String code;
        String message;

        public ProjectBusinessError (String code, String message) {
            this.code = code;
            this.message = message;
        }

        override
        public string toString() {
            return JSON.serialize(this);
        }

    }

}