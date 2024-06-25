part of employer_api;

class ProfileEmployeeApi extends Fetchly {
  Future<ResHandler> getProfileEmployee() async => await get('users/employers');

  Future<ResHandler> updateProfileEmployee(Map<String, dynamic> map, int id) async =>
      await put('users/employers/$id', FormData.fromMap(map));
}
