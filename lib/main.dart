import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Screens/admin/admin_login.dart';
import 'package:scheduler/Screens/selector_actor.dart';
import 'package:scheduler/Screens/splash_screen.dart';
import 'package:scheduler/Screens/student/student_class_select.dart';
import 'package:scheduler/Screens/student/student_homepage.dart';
import 'package:scheduler/Screens/student/student_login.dart';
import 'package:scheduler/Screens/teacher/teacher_login.dart';
import 'package:scheduler/Screens/teacher/teacher_name_select.dart';
import 'package:scheduler/Screens/admin/admin_signup.dart';
import 'package:scheduler/firebase_options.dart';

void main() async {
  // Initialize Firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String screen = 'mainDart';
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        SelectActor.screen: (context) => const SelectActor(),
        StudentLogin.screen: (context) => const StudentLogin(),
        StudentClassSelect.screen: (context) => const StudentClassSelect(),
        TeacherLogin.screen: (context) => const TeacherLogin(),
        TeacherNameSelect.screen: (context) => const TeacherNameSelect(),
        AdminLogin.screen: (context) => const AdminLogin(),
        AdminSignUp.screen: (context) => const AdminSignUp(),
        StudentHomepage.screen: (context) => const StudentHomepage(),
        SplashScreen.screen: (context) => const SplashScreen(),
      },
    );
  }
}
