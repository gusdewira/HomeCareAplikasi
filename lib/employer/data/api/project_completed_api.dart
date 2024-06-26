part of employer_api;

class ProjectCompletedApi extends Fetchly {
  Future<ResHandler> getProject() async =>await get('employer/projects');
}
