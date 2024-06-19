part of api;

class ProjectProgressApi extends Fetchly {
  Future<ResHandler> getProjectProgress() async =>await get('freelancer/projects/accepts');
  Future<ResHandler> getHistoryProgress(int id) async =>await get('freelancer/project_progresses/$id');
}
