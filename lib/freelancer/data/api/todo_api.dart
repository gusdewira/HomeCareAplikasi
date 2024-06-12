part of api;

class TodoApi extends Fetchly {
  Future<ResHandler> getTodos({int limit = 15}) async => await get('todo', query: {'limit': limit});
  Future<ResHandler> createTodo(Map<String, dynamic> data) async => await post('todo', data);
  Future<ResHandler> updateTodo(Map<String, dynamic> data, int id) async => await put('todo/$id', data);
  Future<ResHandler> deleteTodo(int id) async => await delete('todo/$id');
}