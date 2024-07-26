part of employer_api;

class ProjectsApi extends Fetchly {
  Future<ResHandler> approveBid(int id) async =>await put('employer/project_offers/$id', FormData.fromMap({"status": 1}));
  Future<ResHandler> rejectBid(int id) async =>await put('employer/project_offers/$id', FormData.fromMap({"status": 0}));
  Future<ResHandler> getProject() async =>await get('employer/projects');
  Future<ResHandler> postProject(Map<String, dynamic> data) async =>await post('employer/projects', FormData.fromMap(data));
  Future<ResHandler> getProjectQuery(Map<String, dynamic> query) async =>await get('employer/projects', query: query);
}
