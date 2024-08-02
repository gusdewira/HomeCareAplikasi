part of employer_api;

class NotificationApi extends Fetchly {
  Future<ResHandler> getNotifications() async => await get('notifications');
  Future<ResHandler> postNotificationOffers(Map<String, dynamic> data) async =>
      await post('notifications_tawaran', data);
  Future<ResHandler> postNotificationProgress(
          Map<String, dynamic> data) async =>
      await post('notifications_progresses', data);
  Future<ResHandler> postNotificationStatus(Map<String, dynamic> data) async =>
      await post('notifications_ofers', data);
}
