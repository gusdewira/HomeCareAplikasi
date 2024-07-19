part of employer_api;

class ReviewProject extends Fetchly{
  Future<ResHandler> postReview(Map<String, dynamic> data) async => await post('reviews', data);
}
