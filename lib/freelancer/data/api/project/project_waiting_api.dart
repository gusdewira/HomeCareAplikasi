part of api;

class ProjectBidApi extends Fetchly {
  Future<ResHandler> getProjectBid() async =>await get('freelancer/projects/offers');
}