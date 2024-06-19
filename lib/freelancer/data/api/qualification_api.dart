part of api;

class QualificationApi extends Fetchly {
  Future<ResHandler> getQualification({int limit = 15}) async => await get('user_qualifications', query: {'limit': limit});
  Future<ResHandler> postQualification(Map<String, dynamic> data) async => await post('user_qualifications', data, useFormData: true);
  Future<ResHandler> updateQualification(Map<String, dynamic> data, int id) async => await put('user_qualifications/$id', data);
  Future<ResHandler> deleteQualification(int id) async => await delete('user_qualifications/$id');
}
