part of api;

class ProjectComplatedApi extends Fetchly {
  Future<ResHandler> getProjectComplated() async =>await get('freelancer/projects/end');
}