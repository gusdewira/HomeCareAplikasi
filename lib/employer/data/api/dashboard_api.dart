part of employer_api;

class DashboardApi extends Fetchly {
  Future<ResHandler> getFreelancer() async =>await get('dashboard/freelancer');
}
