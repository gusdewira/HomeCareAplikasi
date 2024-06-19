part of api;

class ProjectFreelancerApi extends Fetchly {

  Future<ResHandler> getProjectFreelancer() async =>await get('freelancer/projects');
  Future<ResHandler> getDetailProjectFreelancer(int id) async => get('freelancer/projects/$id');

  Future<ResHandler> getProjectFreelancerByProfile(int freelancerId) async{
    final data = await getProjectFreelancer();

    return data;
  }
}
