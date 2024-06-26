part of employer_api;

class ProjectsApi extends Fetchly {
  Future<ResHandler> getProject() async =>await get('employer/projects');
  Future<ResHandler> getProjectQuery(Map<String, dynamic> query) async =>await get('employer/projects', query: query);
}
