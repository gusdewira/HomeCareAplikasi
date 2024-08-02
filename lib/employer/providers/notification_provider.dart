import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
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
          state = AsyncValue.data(
              data.map((e) => NotificationModel.fromJson(e)).toList());
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

final notificationProvider = StateNotifierProvider.autoDispose<
    NotificationProvider, AsyncValue<List<NotificationModel>>>((ref) {
  return NotificationProvider();
});

class NotificationOffersProvider with ChangeNotifier, UseApi1 {
  Future postNotification(Map<String, dynamic> data) async {
    try {
      if (data.isNotEmpty) {
        ResHandler res = await notificationApi.postNotificationOffers(data);
        return res;
      } else {
        LzToast.show("Data is empty!");
        return {"status": false, "data": {}};
      }
    } catch (e, s) {
      logg('Error: $e, StackTrace: $s');
      LzToast.show('An error occurred during postNotification.');
      return {"status": false, "data": {}};
    } finally {
      LzToast.dismiss();
    }
  }
}

final notificationOffersProvider =
    ChangeNotifierProvider((ref) => NotificationOffersProvider());

class NotificationProgressProvider with ChangeNotifier, UseApi1 {
  Future postNotification(Map<String, dynamic> data) async {
    try {
      if (data.isNotEmpty) {
        ResHandler res = await notificationApi.postNotificationProgress(data);
        return res;
      } else {
        LzToast.show("Data is empty!");
        return {"status": false, "data": {}};
      }
    } catch (e, s) {
      logg('Error: $e, StackTrace: $s');
      LzToast.show('An error occurred during postNotification.');
      return {"status": false, "data": {}};
    } finally {
      LzToast.dismiss();
    }
  }
}

final notificationProgressProvider =
    ChangeNotifierProvider((ref) => NotificationProgressProvider());

class NotificationStatusProvider with ChangeNotifier, UseApi1 {
  Future postNotification(Map<String, dynamic> data) async {
    try {
      if (data.isNotEmpty) {
        ResHandler res = await notificationApi.postNotificationStatus(data);
        return res;
      } else {
        LzToast.show("Data is empty!");
        return {"status": false, "data": {}};
      }
    } catch (e, s) {
      logg('Error: $e, StackTrace: $s');
      LzToast.show('An error occurred during postNotification.');
      return {"status": false, "data": {}};
    } finally {
      LzToast.dismiss();
    }
  }
}

final notificationStatusProvider =
    ChangeNotifierProvider((ref) => NotificationStatusProvider());
