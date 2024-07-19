import 'package:go_router/go_router.dart';
import 'package:fetchly/models/request.dart' as fetchly;
import 'package:lazyui/lazyui.dart';
import '../../data/local/storage.dart';
import '../../routes/paths.dart';
import '../constants/value.dart';

class RequestHandler {
  static void onRequest(fetchly.Request request) {
    final String path = request.path;
    final int status = request.status;
    final dynamic data = request.data;

    if (status == 401 && path != 'auth/login') {
      LzToast.show('Unauthorized, please login again.');

      prefs.remove('token');
      globalContext.go(Paths.login);
    }
  }
}
