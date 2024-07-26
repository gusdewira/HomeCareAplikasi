part of employer_api;

class ProfileEmployeeApi extends Fetchly {
  Future<ResHandler> getProfileEmployee() async => await get('users/employers');
  Future<ResHandler> updateEditProfile(Map<String, dynamic> data) async => await post('users/employers', data);
  Future<ResHandler> updateImageProfile(Map<String, dynamic> data) async => await post('users/employers', FormData.fromMap(data));

  Future<ResHandler> updateProfileEmployee(Map<String, dynamic> map, int id) async =>
      await put('users/employers/$id', FormData.fromMap(map));
}
