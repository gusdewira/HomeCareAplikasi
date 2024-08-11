part of employer_api;

class ProjectActivesApi extends Fetchly {
  Future<ResHandler> getProjectActive() async =>await get('employer/projects/accepts');
  Future<ResHandler> getHistoryProgress() async =>await get('freelancer/project_progresses');
  Future<ResHandler> postProgress(Map<String, dynamic> map) async => await post('freelancer/project_progresses', FormData.fromMap(map));
}
