part of api;

class ProjectFreelancerApi extends Fetchly {
  Future<ResHandler> getProjectFreelancer() async =>await get('freelancer/projects');
}