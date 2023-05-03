import 'package:astronomy_picture/core/util/notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@GenerateNiceMocks([MockSpec<FlutterLocalNotificationsPlugin>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late FlutterLocalNotificationsPlugin notificationsPlugin;
  late NotificationsImpl notifications;

  const MethodChannel channel =
      MethodChannel('dexterous.com/flutter/local_notifications');
  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    notificationsPlugin = FlutterLocalNotificationsPlugin();
    // ignore: always_specify_types
    channel.setMockMethodCallHandler((methodCall) async {
      log.add(methodCall);
      if (methodCall.method == 'initialize') {
        return true;
      } else if (methodCall.method == 'pendingNotificationRequests') {
        return <Map<String, Object?>>[];
      } else if (methodCall.method == 'getActiveNotifications') {
        return <Map<String, Object?>>[];
      } else if (methodCall.method == 'getNotificationAppLaunchDetails') {
        return null;
      }
    });
    notifications = NotificationsImpl(notificationsPlugin: notificationsPlugin);
  });

  test('Should create a schedule daily notificatio', () async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await notificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Australia/Sydney'));
    final tz.TZDateTime scheduledDate =
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));

    await notifications.scheduleDailyNotification(
        id: 1,
        title: "Teste Notifications",
        body: "Teste Notifications",
        schedule: scheduledDate);

    expect(
        log.last,
        isMethodCall('zonedSchedule', arguments: <String, Object>{
          "id": 1,
          "title": "Teste Notifications",
          "body": "Teste Notifications",
          "platformSpecifics": {
            "icon": null,
            "channelId": "channelId",
            "channelName": "channelName",
            "channelDescription": "channelDescription",
            "channelShowBadge": true,
            "channelAction": 0,
            "importance": 3,
            "priority": 0,
            "playSound": true,
            "enableVibration": true,
            "vibrationPattern": null,
            "groupKey": null,
            "setAsGroupSummary": false,
            "groupAlertBehavior": 0,
            "autoCancel": true,
            "ongoing": false,
            "colorAlpha": null,
            "colorRed": null,
            "colorGreen": null,
            "colorBlue": null,
            "onlyAlertOnce": false,
            "showWhen": true,
            "when": null,
            "usesChronometer": false,
            "chronometerCountDown": false,
            "showProgress": false,
            "maxProgress": 0,
            "progress": 0,
            "indeterminate": false,
            "enableLights": false,
            "ledColorAlpha": null,
            "ledColorRed": null,
            "ledColorGreen": null,
            "ledColorBlue": null,
            "ledOnMs": null,
            "ledOffMs": null,
            "ticker": null,
            "visibility": null,
            "timeoutAfter": null,
            "category": null,
            "fullScreenIntent": false,
            "shortcutId": null,
            "additionalFlags": null,
            "subText": null,
            "tag": null,
            "colorized": false,
            "number": null,
            "audioAttributesUsage": 5,
            "style": 0,
            "styleInformation": {
              "htmlFormatContent": false,
              "htmlFormatTitle": false
            },
            "scheduleMode": "exactAllowWhileIdle"
          },
          "timeZoneName": "Australia/Sydney",
          "scheduledDateTime": "2023-05-02T04:09:45",
          "scheduledDateTimeISO8601": "2023-05-02T04:09:45.433716+1000"
        }));
  });
}
