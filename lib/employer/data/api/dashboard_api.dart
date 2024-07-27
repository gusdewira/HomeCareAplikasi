part of employer_api;

class DashboardApi extends Fetchly {
  Future<ResHandler> getFreelancer(Map<String, dynamic>? dataQuery) async =>await get('dashboard/freelancer', query: dataQuery);
}
