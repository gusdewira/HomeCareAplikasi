part of api;

class ProjectProgressApi extends Fetchly {
  Future<ResHandler> getProjectProgress() async =>await get('freelancer/projects/accepts');
}