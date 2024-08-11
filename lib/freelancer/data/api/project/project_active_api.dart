part of api;

class ProjectProgressApi extends Fetchly {
  Future<ResHandler> getProjectProgress() async =>await get('freelancer/projects/accepts');
  Future<ResHandler> getHistoryProgress() async =>await get('freelancer/project_progresses');
  Future<ResHandler> postProgress(Map<String, dynamic> map) async => await post('freelancer/project_progresses', FormData.fromMap(map));
}
