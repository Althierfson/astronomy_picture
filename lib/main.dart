import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/core/util/notifications.dart';
import 'package:astronomy_picture/route_generato.dart';
import 'package:astronomy_picture/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  setupContainer();
  runApp(const AstronomyPicture());
}

class AstronomyPicture extends StatelessWidget {
  const AstronomyPicture({super.key});

  @override
  Widget build(BuildContext context) {
    initNotifications();
    return MaterialApp(
      title: 'Astronomy Picture',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: getIt<RouteGenerato>().generateRoute,
      theme: PersonalTheme().theme,
      initialRoute: '/',
    );
  }

  initNotifications() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()));
    final tz.TZDateTime scheduledDate =
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
    await getIt<Notifications>().initNotification();
    getIt<Notifications>().scheduleDailyNotification(
        id: 1,
        title: "What's the picture of the day?",
        body: "Go to APP to check out!",
        schedule: scheduledDate);
  }
}
