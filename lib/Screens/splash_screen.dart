import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Screens/select_actor.dart';
import 'package:scheduler/Screens/student/databaseFetch_student.dart';
import 'package:scheduler/Screens/student/student_homepage.dart';
import '../Notification/notification_services.dart';
import '../Widgets/shared_prefs.dart';
import '../tmp/temp_file.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String screen = 'splashScreen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Widget defaultScreen = const SelectActor();

class _SplashScreenState extends State<SplashScreen> {
  bool checkIsStudentLogin = false;
  void updateStatus() async {
    bool? checkIfLoggedIn = await checkStudentLogInStatus();
    setState(() {
      checkIsStudentLogin = checkIfLoggedIn ?? false;
    });
  }

  @override
  void initState() {
    //scheduleNotification
    NotificationServices notificationServices = NotificationServices();
    WidgetsFlutterBinding.ensureInitialized();
    notificationServices.initializeNotifications();
    // notificationServices.zoneScheduleNotifications(
    //     'Test', 'This is body', timeList, const Duration(minutes: 1));

    //check login status of student
    updateStatus();
    //updateTheme after user logins
    updateTheme();
    super.initState();

    //send notification function
    notificationServices.sendNotifications(
        'Test', 'application Loaded successfully');
    notificationServices.zoneScheduleNotifications(
        'Next Class in 5 minutes.',
        'Class will start shortly',
        subjectName,
        startingTime,
        const Duration(minutes: 5));
  }

  void updateTheme() async {
    bool? checkDarkMode = await selectedThemeMode();
    setState(() {
      isLightMode = checkDarkMode!;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (checkIsStudentLogin) {
      defaultScreen = const StudentHomepage();
    } else {
      // If user is not logged in or has an unverified email, load SelectActor screen
      if (currentUser == null || !currentUser.emailVerified) {
        if (currentUser?.emailVerified == false) {
          FirebaseAuth.instance.signOut();
        }
        defaultScreen = const SelectActor();
      }
      // Else load TempWidget
      else {
        defaultScreen = TempWidget(user: currentUser);
      }
    }
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => defaultScreen)));
    //loading ring
    const spinkit = SpinKitRing(
      color: Colors.pinkAccent,
      size: 60.0,
      lineWidth: 5,
    );

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.transparent,
                child: Image(
                  image: AssetImage(
                    'Assets/images/logo.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              spinkit,
              SizedBox(
                height: 10,
              ),
              Text(
                'Loading',
                style: TextStyle(
                    fontSize: 25, fontFamily: 'poppins', color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
