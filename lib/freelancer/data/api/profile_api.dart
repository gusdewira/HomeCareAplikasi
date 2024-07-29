part of api;

class ProfileApi extends Fetchly {
  Future<ResHandler> getProfileFreelancer() async =>await get('users/freelancers');
  Future<ResHandler> updateImageProfile(Map<String, dynamic> data) async => await post('users/freelancers', FormData.fromMap(data));
  Future<ResHandler> updateProfile(Map<String, dynamic> map, int id ) async =>
     await put('users/freelancers/$id', FormData.fromMap(map));
}