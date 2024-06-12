part of api;

class ExperienceApi extends Fetchly {
  Future<ResHandler> getExperience({int limit = 15}) async => await get('user_experiences', query: {'limit': limit});
  Future<ResHandler> postExperience(Map<String, dynamic> data) async => await post('user_experiences', data);
  Future<ResHandler> updateExperience(Map<String, dynamic> data, int id) async => await put('user_experiences/$id', data);
  Future<ResHandler> deleteExperience(int id) async => await delete('user_experiences/$id');
}
