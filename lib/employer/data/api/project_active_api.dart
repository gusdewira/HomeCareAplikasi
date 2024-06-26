part of employer_api;

class ProjectActivesApi extends Fetchly {
  Future<ResHandler> getProjectActive() async =>await get('freelancer/projects/accepts');
  Future<ResHandler> getHistoryProgress(int id) async =>await get('freelancer/project_progresses/$id');
  Future<ResHandler> postProgress(Map<String, dynamic> map) async => await post('freelancer/project_progresses', FormData.fromMap(map));
}
