part of api;

class EditProfileApi extends Fetchly {
  Future<ResHandler> getEditProfile() async => await get('users/freelancers');
  Future<ResHandler> postEditProfile(Map<String, dynamic> data) async =>
      await post('users/freelancers/', data);
  Future<ResHandler> updateEditProfile(Map<String, dynamic> data) async =>
      await post('users/freelancers', FormData.fromMap(data));
  Future<ResHandler> updateEditPortfolio(FormData data) async {
    return await post('users/freelancers', data);
  }
  Future<ResHandler> deleteProfile(int id) async =>
      await delete('user/portofolio-attachments/$id');
  Future<ResHandler> updateImageProfile(Map<String, dynamic> data) async =>
      await post('users/freelancers', FormData.fromMap(data));
}
