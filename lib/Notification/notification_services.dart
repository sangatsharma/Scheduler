import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationServices {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('logo');

  Future<void> initializeNotifications() async {
    // flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.requestPermission();
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> sendNotifications(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'one time',
      'Notices',
      importance: Importance.max,
      priority: Priority.high,
      // sound: RawResourceAndroidNotificationSound('bell'),
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails);
  }

  Future<void> zoneScheduleNotifications(
      String title,
      String body,
      List<String> subjList,
      List<String> timeList,
      /*List<String> amOrPm,*/ Duration duration) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'Next Class',
      'Upcoming classNotifier',
      importance: Importance.max,
      priority: Priority.high,
      // sound: RawResourceAndroidNotificationSound('bell'),
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    tz.initializeTimeZones();
    for (int i = 0; i < timeList.length; i++) {
      DateTime now = DateTime.now();

      final String dateTimeString =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${timeList[i]}:00';

      DateTime dateTime = DateTime.parse(dateTimeString);
      // DateTime notificationTime = dateTime.subtract(const Duration(minutes: 5));
      DateTime notificationTime = dateTime.subtract(duration);
      await flutterLocalNotificationsPlugin.zonedSchedule(
        i, // Use a unique notification ID
        title,
        '${subjList[i]} $body',
        tz.TZDateTime.from(notificationTime, tz.local),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }
}

//to show notification use below code
//notificationServices.sendNotifications('example', 'This is an example');
// final List<String> timeList = ['09:50', '09:53', '09:55', '21:58'];
// notificationServices.zoneScheduleNotifications(
// 'Test', 'This is body', timeList, const Duration(minutes: 1));
