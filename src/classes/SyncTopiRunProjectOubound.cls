public class SyncTopiRunProjectOubound {

    ProjectRepository projectRepository;
    TopiRunProjectTransformer transformer;
    
    public SyncTopiRunProjectOubound() {

        projectRepository = new ProjectRepository();
        transformer = new TopiRunProjectTransformer();

    }
  
    public Project__c sendProject(Project__c project) {
        Http http = new Http();

        HttpResponse response = http.send(buildResquest(project));

        if(response.getStatusCode() != 200) {
            
            TopiRunErrorResponse errorResponse = (TopiRunErrorResponse) JSON.deserialize(response.getBody(), TopiRunErrorResponse.class);
            project = transformer.toTopiRunProject(project, errorResponse);
        }

        TopiRunProjectResponse topiRunProjectResponse = (TopiRunProjectResponse) JSON.deserialize(response.getBody(), TopiRunProjectResponse.class);
        project = transformer.toTopiRunProject(project, topiRunProjectResponse);

        return project;
    }

    private HttpRequest buildResquest(Project__c project) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://run.mocky.io/v3/58d750c1-31bf-45ae-b361-bedecacf55a2');
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json');

        TopiRunProjectRequest topiRunProjectRequest = transformer.toTopiRunProject(project);

        String payload = JSON.serialize(topiRunProjectRequest);

        request.setBody(payload);

        return request;

    }

}