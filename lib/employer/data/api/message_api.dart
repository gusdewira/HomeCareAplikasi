part of employer_api;

class MessageApi extends Fetchly {
  Future<ResHandler> getMessage() async => await get('messages');
  Future<ResHandler> filterMessage(String text) async =>
      await get('index_fillters?message_text=$text');
  Future<ResHandler> postMessage(Map<String, dynamic> data) async =>
      await post('messages', data);
  Future<ResHandler> updateMessage(Map<String, dynamic> data, int id) async =>
      await put('messages/$id', data);
  Future<ResHandler> deleteMessage(int id) async =>
      await delete('messages/$id');
}
