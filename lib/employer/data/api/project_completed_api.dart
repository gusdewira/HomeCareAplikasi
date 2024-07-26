part of employer_api;

class ProjectCompletedApi extends Fetchly {
  Future<ResHandler> getProject() async =>await get('employer/projects/end');
  Future<ResHandler> endProject(String id) async => await put('employer/project_offers/$id', { status: 3 });
}