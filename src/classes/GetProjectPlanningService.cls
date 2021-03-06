/*
* @author anderson.silva
*/

public class GetProjectPlanningService {

    ProjectRepository projectRepository;

    public GetProjectPlanningService() {
        projectRepository = new ProjectRepository();
    }

    ProjectEnterpriseResponse getDataSynchronize() {

        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://run.mocky.io/v3/58d750c1-31bf-45ae-b361-bedecacf55a2');
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json');

        Http http = new Http();
        HttpResponse response = http.send(request);

        String payload = response.getBody();

        System.debug('payload: ' + payload);

        if(response.getStatus != 200) {
            //error
        }

        return (ProjectEnterpriseResponse) JSON.deserialize(payload, ProjectEnterpriseResponse.class);
    }

    public void integrationEnterpriseProcessor() {
        ProjectEnterpriseResponse response = getDataSynchronize();
        List<Project__c> projects = this.projectRepository.findbyCode(response.projectId);

        for(Project__c project : projects) {
             //set values
             //save
        }

    }

}