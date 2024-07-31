import 'package:fetchly/fetchly.dart';
import 'package:homecare_app/employer/data/api/api.dart';
import 'package:homecare_app/employer/data/models/notification_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

class NotificationProvider
    extends StateNotifier<AsyncValue<List<NotificationModel>>> with UseApi1 {
  NotificationProvider() : super(const AsyncValue.loading()) {
    getNotifications();
    }

  Future<void> getNotifications() async {
  try {
    state = const AsyncValue.loading();

    ResHandler res = await notificationApi.getNotifications();

    if (res.status) {
      dynamic data = res.data;
      if (data is List) {
        state = AsyncValue.data(data.map((e) => NotificationModel.fromJson(e)).toList());
      } else {
        LzToast.show("Unexpected data type received");
      }
    } else {
      LzToast.show(res.message);
    }
  } catch (e, s) {
    Errors.check(e, s);
  }
}
    }

final notificationProvider =
    StateNotifierProvider.autoDispose<NotificationProvider, AsyncValue<List<NotificationModel>>>((ref) {
  return NotificationProvider();
});