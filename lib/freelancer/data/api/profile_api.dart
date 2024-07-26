part of api;

class ProfileApi extends Fetchly {
  Future<ResHandler> getProfileFreelancer() async =>await get('users/freelancers');

  Future<ResHandler> updateProfile(Map<String, dynamic> map, int id ) async =>
     await put('users/freelancers/$id', FormData.fromMap(map));
}