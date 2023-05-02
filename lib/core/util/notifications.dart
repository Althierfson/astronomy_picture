import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

/// Apod notifications Data Source - Open notifications APP
abstract class Notifications {
  /// Initi Notification
  Future<void> initNotification();

  /// Initi the daily Notification
  Future<void> scheduleDailyNotification(
      {required int id,
      required String title,
      required String body,
      required tz.TZDateTime schedule});
}

class NotificationsImpl implements Notifications {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  NotificationsImpl({required this.notificationsPlugin});

  @override
  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
    FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  @override
  Future<void> scheduleDailyNotification(
      {required int id,
      required String title,
      required String body,
      required tz.TZDateTime schedule}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
    );

    await notificationsPlugin.periodicallyShow(
        id,
        title,
        body,
        RepeatInterval.daily,
        NotificationDetails(android: androidNotificationDetails));
  }
}
