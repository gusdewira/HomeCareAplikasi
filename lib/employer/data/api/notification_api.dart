part of employer_api;

class NotificationApi extends Fetchly{
  Future<ResHandler> getNotifications() async => await get('notifications');
}