part of api;

class RegisterApi extends Fetchly {
  Future<ResHandler>  register(Map<String, dynamic> data) async =>
      await post('register', data);
}