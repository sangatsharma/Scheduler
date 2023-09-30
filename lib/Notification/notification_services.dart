import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationServices {
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
      Map<String, Map<String, List<String>>> data,
      /*List<String> amOrPm,*/ Duration duration) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'Next Class',
      'Upcoming classNotifier',
      importance: Importance.max,
      priority: Priority.high,
      // sound: RawResourceAndroidNotificationSound('bell'),
    );
    int uniqueId = 0;
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    tz.initializeTimeZones();
    int notificationId = uniqueId++;
    for (int day = 1; day <= 7; day++) {
      for (int i = 0;
          i < data[day.toString()]!["starting_times"]!.length;
          i++) {
        String title = 'Your Title';
        String body = 'Your Body';
        String? time = data[day.toString()]!["starting_times"]?[i];

        // Construct the notification time for the current day and time
        DateTime now = DateTime.now();
        // DateTime dateTime = DateTime(now.year, now.month, now.day,
        //     int.parse(time!.split(":")[0]), int.parse(time.split(":")[1]));
        final String dateTimeString =
            '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} $time:00';
        DateTime dateTime = DateTime.parse(dateTimeString);
        // Calculate the notification time for the current day
        Duration duration =
            const Duration(minutes: 5); // You can adjust this as needed
        DateTime notificationTime = dateTime.subtract(duration);

        // Schedule the notification
        await flutterLocalNotificationsPlugin.zonedSchedule(
          notificationId, // Use a unique notification ID
          title,
          '$body ${data[day.toString()]!["teachers_name"]?[i]} ${data[day.toString()]!["subjects"]?[i]}',
          tz.TZDateTime.from(notificationTime, tz.local),
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
        );
      }
    }
  }

// below code here
  // below code here
}

Future<void> cancelNotification() async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

// await flutterLocalNotificationsPlugin.cancelAll();
// await flutterLocalNotificationsPlugin.cancel(notificationId);

//to show notification use below code
//notificationServices.sendNotifications('example', 'This is an example');
// final List<String> timeList = ['09:50', '09:53', '09:55', '21:58'];
// notificationServices.zoneScheduleNotifications(
// 'Test', 'This is body', timeList, const Duration(minutes: 1));

//Future<void> zoneScheduleNotifications(
//     String title,
//     String body,
//     List<String> subjList,
//     List<String> classList,
//     List<String> timeList,
//     /*List<String> amOrPm,*/ Duration duration) async {
//   AndroidNotificationDetails androidNotificationDetails =
//       const AndroidNotificationDetails(
//     'Next Class',
//     'Upcoming classNotifier',
//     importance: Importance.max,
//     priority: Priority.high,
//     // sound: RawResourceAndroidNotificationSound('bell'),
//   );
//
//   NotificationDetails notificationDetails =
//       NotificationDetails(android: androidNotificationDetails);
//   tz.initializeTimeZones();
//
//   for (int i = 0; i < timeList.length; i++) {
//     DateTime now = DateTime.now();
//
//     final String dateTimeString =
//         '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${timeList[i]}:00';
//
//     DateTime dateTime = DateTime.parse(dateTimeString);
//     // DateTime notificationTime = dateTime.subtract(const Duration(minutes: 5));
//     DateTime notificationTime = dateTime.subtract(duration);
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       i, // Use a unique notification ID
//       title,
//       '${classList[i]} ${subjList[i]} $body',
//       tz.TZDateTime.from(notificationTime, tz.local),
//       notificationDetails,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }
// }
