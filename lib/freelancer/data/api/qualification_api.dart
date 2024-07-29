part of api;

class QualificationApi extends Fetchly {
  Future<ResHandler> getQualification({int limit = 15}) async => await get('user_qualifications?limit=$limit');
  Future<ResHandler> postQualification(Map<String, dynamic> data) async => await post('user_qualifications', FormData.fromMap(data));
  Future<ResHandler> updateQualification(Map<String, dynamic> data, int id) async => await post('user_qualifications/$id', FormData.fromMap(data));
  Future<ResHandler> deleteQualification(int id) async => await delete('user_qualifications/$id');
}
