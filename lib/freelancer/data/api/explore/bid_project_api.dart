part of api;

class BidProjectApi extends Fetchly {
  Future<ResHandler> postBidProject(Map<String, dynamic> data) async => await post('freelancer/project-offers', data);

}