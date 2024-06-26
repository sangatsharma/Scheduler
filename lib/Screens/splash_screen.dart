import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Screens/select_actor.dart';
import 'package:scheduler/Screens/student/student_homepage.dart';
import 'package:scheduler/Screens/teacher/teacher_homepage.dart';
import '../Widgets/shared_prefs.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'admin/admin_homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String screen = 'splashScreen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Widget defaultScreen = const SelectActor();

class _SplashScreenState extends State<SplashScreen> {
  bool checkIsStudentLogin = false;
  bool checkIsTeacherLogin = false;
  void updateStatus() async {
    bool? checkIfStudentLoggedIn = await checkStudentLogInStatus();
    bool? checkIfTeacherLoggedIn = await checkTeacherLogInStatus();
    setState(() {
      checkIsStudentLogin = checkIfStudentLoggedIn ?? false;
      checkIsTeacherLogin = checkIfTeacherLoggedIn ?? false;
    });
  }

  @override
  void initState() {
    //check login status of student and teacher
    updateStatus();
    //updateTheme after user logins
    updateTheme();
    super.initState();
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
    } else if (checkIsTeacherLogin) {
      defaultScreen = const TeacherHomepage();
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
        defaultScreen = AdminHomepage(user: currentUser);
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
