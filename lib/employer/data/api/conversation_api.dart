part of employer_api;

class ConversationApi extends Fetchly {
  Future<ResHandler> getConversation() async => await get('conversations');
  Future<ResHandler> postConversation(Map<String, dynamic> data) async =>
      await post('conversations', data);
}
