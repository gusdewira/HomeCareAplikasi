part of api;

class SkillApi extends Fetchly {
  Future<ResHandler> getSkill({int limit = 15}) async => await get('user_skills', query: {'limit': limit});
  Future<ResHandler> postSkill(Map<String, dynamic> data) async => await post('user_skills', data);
  Future<ResHandler> updateSkill(Map<String, dynamic> data, int id) async => await put('user_skills/$id', data);
  Future<ResHandler> deleteSkill(int id) async => await delete('user_skills/$id');
}