import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/notifications_response.dart';
import 'package:sewa_digital/data/model/post_response.dart';

abstract class NotificationRepo {
  Future<NotificationResponse> getNotifications();
  Future<PostResponse> getPostNotifications();
}

class RealNotificationRepo implements NotificationRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<NotificationResponse> getNotifications() {
    return _dataProvider.getNotifications();
  }

  @override
  Future<PostResponse> getPostNotifications() {
    return _dataProvider.getPostNotifications();
  }
}
