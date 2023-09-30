import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Screens/admin/admin_login.dart';
import 'package:scheduler/Screens/admin/class_routine_entry.dart';
import 'package:scheduler/Screens/admin/course_details_entry.dart';
import 'package:scheduler/Screens/admin/teacher_details_entry.dart';
import 'package:scheduler/Screens/select_actor.dart';
import 'package:scheduler/Screens/splash_screen.dart';
import 'package:scheduler/Screens/student/student_class_select.dart';
import 'package:scheduler/Screens/student/student_homepage.dart';
import 'package:scheduler/Screens/student/student_login.dart';
import 'package:scheduler/Screens/teacher/teacher_login.dart';
import 'package:scheduler/Screens/teacher/teacher_name_select.dart';
import 'package:scheduler/Screens/admin/admin_signup.dart';
import 'package:scheduler/firebase_options.dart';
import 'Screens/teacher/teacher_homepage.dart';

void main() async {
  //ensure necessary platform-specific dependencies
  // and services are available for the Flutter application to run.
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String screen = 'mainDart';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ClassRoutineEntry(),
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
        TeacherHomepage.screen: (context) => const TeacherHomepage(),
        TeacherDetailsEntry.screen: (context) => const TeacherDetailsEntry(),
        CourseDetailsEntry.screen: (context) => const CourseDetailsEntry(),
        ClassRoutineEntry.screen: (context) => const ClassRoutineEntry(),
        // AdminHomepage.screen: (context) => const AdminHomepage(user: null),
        // GetInstitutionDetails.screen: (context) =>
        //     const GetInstitutionDetails(),
      },
    );
  }
}
